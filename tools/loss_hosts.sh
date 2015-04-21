#!/usr/bin/env bash
#
# 比较A, B两个hosts文件, 找出在B不在A的域名
# EP:
# $ ./loss_hosts.sh hosts_a hosts_b
#
# Author: cloud@txthinking.com
#

if [ $# -ne 2 ]
then
    echo -e "Usage:\n";
    echo -e "    $ ./loss_hosts.sh hosts_a hosts_b\n"
    echo -e "\nView loss_hosts.sh file to see more.\n"
    exit 0;
fi
a=_a
b=_b
cat $1 | awk '{print $2}' | sort | uniq > $a
cat $2 | awk '{print $2}' | sort | uniq > $b
comm -13 $a $b
rm $a $b
