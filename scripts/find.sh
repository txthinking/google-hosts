#!/usr/bin/env bash
#
# 这个是getssl.sh的一个wrapper
# 
# EP: 查询192.168.x.x的IP
# $ ./find 192.168
#
# Author: cloud@txthinking.com
#

# TODO receive more type
for((i=0;i<255;i++))
do
    ./getssl.sh ${1}.${i}
done
