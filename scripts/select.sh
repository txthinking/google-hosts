#!/usr/bin/env bash
#
# 从output内的IP里选择除最优的IP, 并调用use.sh和dnsmasq.sh
#
# EP:
# $ ./select.sh
#
# Author: cloud@txthinking.com
#

if [ ! -d output ]
then
    echo "no output directory.";
    exit 0;
fi

domains="
    *.google.com
    accounts.google.com
    checkout.google.com
    adwords.google.com
    mail.google.com
    *.mail.google.com
    *.googleusercontent.com
    *.gstatic.com
    *.googleapis.com
    *.appspot.com
    *.googlecode.com
    *.google-analytics.com
    ssl.google-analytics.com
    "
>../google.dnsmasq.conf
filter_data=/tmp/filter.sh.data
for domain in $domains
do
    ./filter.sh $domain > $filter_data
    _ip=""
    line=""
    while read line
    do
        ip=$(echo $line | awk '{print $5}')
        c=$(nmap --host-timeout 2s $ip -p 443 2>/dev/null | grep -Pc "443/tcp open")
        if [ $c -ne 1 ]
        then
            continue
        fi
        cer=$(curl https://$ip 2>&1 | grep -Po "'\S*'" |head -1|cut -d \' -f 2)
        if [ "$cer" != $domain ]
        then
            continue
        fi
        if [ $domain = "*.google.com" ]
        then
            #c=$(echo $ip | grep -Pc "^(173|207|209|216|64|66|72|74)")
            c=$(echo $ip | grep -Pc "^(173|207|209|64|66|72|74)")
            if [ $c -ne 1 ]
            then
                continue
            fi
            c=$(nmap --host-timeout 2s $ip -p 5222 2>/dev/null | grep -Pc "5222/tcp open")
            if [ $c -eq 1 ]
            then
                continue
            fi
        fi
        _ip=$ip
        break
    done < $filter_data

    if [ -z "$line" ]
    then
        echo "[WARNING] $domain"
        continue
    fi
    if [ -z "$_ip" ]
    then
        echo "[WARNING] $domain"
        continue
    fi

    echo $line
    ./use.sh $domain $ip

    if [ $domain != "*.mail.google.com" ]
    then
        ./dnsmasq.sh $(echo $domain | sed -r "s/\*\.//") $ip
    fi

    # extra
    if [ $domain = "*.googleusercontent.com" ]
    then
        ./use.sh *.ggpht.com $ip
        ./dnsmasq.sh ggpht.com $ip
    elif [ $domain = "*.googleapis.com" ]
    then
        ./use.sh googleapis.com $ip
        ./use.sh talkgadget.google.com $ip
        ./use.sh *.talkgadget.google.com $ip
        ./dnsmasq.sh talkgadget.google.com $ip
    elif [ $domain = "*.appspot.com" ]
    then
        ./use.sh appspot.com $ip
    elif [ $domain = "*.mail.google.com" ]
    then
        for host in $(grep -P "\w+\.mail\.google\.com" hosts.all | awk '{print $2}')
        do
            ./dnsmasq.sh $host $ip
        done
    elif [ $domain = "*.google.com" ]
    then
        ./use.sh google.com $ip
        for host in $(grep -P -A 9999 "OTHERS$" hosts.all | awk '{print $2}')
        do
            ./use.sh $host $ip
            ./dnsmasq.sh $host $ip
        done
    fi
done
