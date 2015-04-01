#!/usr/bin/env bash
#
# 这个是getssl.sh的一个wrapper
# EP:
# $ ./find 192.168.1.1/24
#
# Author: cloud@txthinking.com
#

if [ $# -eq 0 ]
then
    echo -e "Usage:\n";
    echo -e "    $ ./find.sh 192.168.1.1/24"
    echo -e "\nView find.sh file to see more.\n"
    exit 0;
fi

if [ ! -d output ]
then
    mkdir output
fi

first=$(./iprange_$(uname -m) $1 | awk '{print $1}')
last=$(./iprange_$(uname -m) $1 | awk '{print $2}')
output=output/$first-$last
> $output

max_process=100
fd=/tmp/google-hosts.fd
mkfifo $fd
exec 9<>$fd
rm $fd
for((i=0;i<$max_process;i++))
do
    echo
done >&9

n=0
for((i=$first;i<$last;i++))
do
    {
        read -u9
        {
            ip=$(./d2ip_$(uname -m) $i)
            out=$(./getssl.sh $ip)
            echo -e "$out"
            echo -e "$out" >> $output
            echo >&9
        }
    }&
    n=$(($n+1))
    if [ $(($n%$(($max_process*2)))) -eq 0 ]
    then
        wait
    fi
done
wait
exec 9>&-
