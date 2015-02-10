#!/usr/bin/env bash
# 
# 寻找IP并自动更新
#
# Author: cloud@txthinking.com
#

for i in $(nslookup -q=TXT _netblocks.google.com 8.8.4.4 | grep -Po '\d+\.\d+\.\d+.\d+' | grep -Pv '8.8' | grep -Po '^\d+\.\d+')
do
    ./find.sh $i
done
./select.sh
./apply.sh
