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
    p=${domain//\./\\\.};
    p=${p//\*/\\\*};
    line=$(grep -Eh "\s$p$" output/* | sort -k2n -k3n |head -1)

    if [ -z "$line" ]
    then
        echo "[WARNING] $domain";
        continue;
    fi
    echo $line;
    ip=$(echo $line | cut -d " " -f 1)
    ./use.sh $domain $ip
done
