#!/usr/bin/env bash
#
# 这个是getssl.sh的一个wrapper, 可同时接受一个或多个参数
# EP:
# 比如要查询192.168.x.x, 192.169.1.x, 192.170.1.x, 192.170.x.x
# $ ./find 192.168 192.169.1 192.170.1 192.171
#
# Author: cloud@txthinking.com
#

if [ $# -eq 0 ]
then
    echo -e "Usage:\n";
    echo -e "    $ ./find.sh 192.168"
    echo -e "    $ ./find.sh 192.168.1"
    echo -e "    $ ./find.sh 192.168 192.169 192.170.1"
    echo -e "\nView find.sh file to see more.\n"
    exit 0;
fi

for n
do
    if [ -n "$(echo $n | cut -d . -f 3)" ]
    then
        ./getssl.sh $n
    else
        for((i=0;i<255;i++))
        do
            ./getssl.sh ${n}.${i}
        done
    fi
done
