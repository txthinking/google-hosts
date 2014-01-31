#!/usr/bin/env bash
#
# Author: cloud@txthinking.com
#
# param $1 like "192.168"
#
d=$(pwd)
for((i=0;i<255;i++))
do
    $d/getssl.sh ${1}.${i}
done
echo "[INFO] Done in /tmp/${1}.N"

