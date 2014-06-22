#!/usr/bin/env bash
#
# 从output内的IP里选择除最优的IP, 并调用use.sh
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
filter_data=/tmp/filter.sh.data
for domain in $domains
do
    ./filter.sh $domain > $filter_data
    while read line
    do
        ip=$(echo $line | awk '{print $1}')
        c=$(nmap --host-timeout 3s $ip -p 443 2>/dev/null | grep -Ec "443/tcp open")
        if [ $c -ge 1 ]
        then
            echo $line
            break
        fi
    done < $filter_data

    if [ -z "$line" ]
    then
        echo "[WARNING] $domain"
        continue
    fi
    ./use.sh $domain $ip

    # extra
    if [ $domain = "*.googleusercontent.com" ]
    then
        ./use.sh *.ggpht.com $ip
    elif [ $domain = "*.googleapis.com" ]
    then
        ./use.sh talkgadget.google.com $ip
    elif [ $domain = "*.appspot.com" ]
    then
        ./use.sh appspot.com $ip
    elif [ $domain = "*.google.com" ]
    then
        ./use.sh google.com $ip
        for host in $(grep -E -A 9999 "cn$" hosts.all | awk '{print $2}')
        do
            ./use.sh $host $ip
        done
    fi
done
