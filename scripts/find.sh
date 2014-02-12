#!/usr/bin/env bash
#
# Author: cloud@txthinking.com
#
# param $1 like "192.168"
#
for((i=0;i<255;i++))
do
    ./getssl.sh ${1}.${i}
done

