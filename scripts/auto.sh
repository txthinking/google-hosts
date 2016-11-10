#!/usr/bin/env bash
# 
# 寻找IP并自动更新
#
# Author: cloud@txthinking.com
#

if [ $# -eq 0 ]
then
    echo -e "Usage:\n";
    echo -e "    $ ./auto.sh DNS"
    echo -e "\nDNS is like 8.8.8.8, but you should try DNS in diffrent countries.\n"
    echo -e "\nView auto.sh file to see more.\n"
    exit 0;
fi

for i in $(nslookup -q=TXT _netblocks.google.com $1 | grep -Po '\d+\.\d+\.\d+.\d+\/\d+')
do
    ./find.sh $i
done
./select.sh
./apply.sh
