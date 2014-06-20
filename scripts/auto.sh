#!/usr/bin/env bash
# 
# 寻找IP并自动更新
#
# Author: cloud@txthinking.com
#

if [ $# -lt 0 ]
then
    echo -e "Usage:\n"
    echo -e "    $ ./auto.sh 192.168"
    echo -e "    $ ./auto.sh 192.168.1"
    echo -e "    $ ./auto.sh 192.168 192.169 192.170.1"
    echo -e "\nView auto.sh file to see more.\n"
fi

for n
do
    ./find.sh $n
done
./select.sh
./apply.sh
