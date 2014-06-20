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
    google.com
    *.google.com
    www.google.com
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
    "
for domain in $domains
do
    p=${domain//\./\\\.}
    p=${p//\*/\\\*}
    line=$(grep -Eh "\s$p$" output/* | sort -k2n -k3n |head -1)

    if [ -z "$line" ]
    then
        echo "[WARNING] $domain"
        continue
    fi
    echo $line
    ip=$(echo $line | awk '{print $1}')
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
        for host in $(grep -E -A 9999 "cn$" hosts.all | awk '{print $2}')
        do
            ./use.sh $host $ip
        done
    fi
done
