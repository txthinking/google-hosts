#!/usr/bin/env bash
#
# 从output内的IP里过滤IP
#
# EP:
# 过滤ssl域名为的*.google.com的IP
# $ ./filter.sh *.google.com
# 过滤ssl域名为的mail.google.com的IP
# $ ./filter.sh mail.google.com
#
# Author: cloud@txthinking.com
#

if [ $# -eq 0 ]
then
    echo -e "Usage:\n";
    echo -e "    $ ./filter.sh *.google.com"
    echo -e "    $ ./filter.sh mail.google.com"
    echo -e "\nView filter.sh file to see more.\n"
    exit 0;
fi

if [ ! -d output ]
then
    echo "no output directory.";
    exit 0;
fi

p=${1//\./\\\.}
p=${p//\*/\\\*}
grep -Ph "\s$p$" output/* | sort -k2n -k3n
