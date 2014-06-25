#!/usr/bin/env bash
# 
# 替换指定域名的IP, 并将其写入hosts.all
#
# EP:
# 模糊替换:
# $ ./use.sh *.google.com 192.168.1.1 # 会替换a.google.com,b.a.google.com
# 明确替换:
# $ ./use.sh www.google.com 192.168.1.1 # 只会替换www.google.com
#
# Author: cloud@txthinking.com
#

if [ $# -lt 2 ]
then
    echo -e "Usage:\n"
    echo -e "    $ ./use.sh DOMAIN IP"
    echo -e "\nView use.sh file to see more.\n"
    exit 0
fi

if [ "$(echo $1 | cut -d . -f 1)" = "*" ]
then
    p=${1//\./\\\.}
    sed -i -r "s/.*?    (.$p)$/$2    \1/" hosts.all
else
    p=${1//\./\\\.}
    sed -i -r "s/.*?    ($p)$/$2    \1/" hosts.all
fi
