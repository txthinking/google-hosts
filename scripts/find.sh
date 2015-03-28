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

first=$(./iprange_64 $1 | awk '{print $1}')
last=$(./iprange_64 $1 | awk '{print $2}')
output=output/$first-$last
> $output

max_process=99
fd=/tmp/google-hosts.fd
mkfifo $fd
exec 9<>$fd
rm $fd
for((i=0;i<$max_process;i++))
do
    echo
done >&9

for((i=$first;i<$last;i++))
do
    {
        read -u9
        {
            ip=$(./d2ip_64 $i)
            out=$(./getssl.sh $ip)
            echo $out
            echo $out >> $output
            echo >&9
        }
    }&
done
wait
exec 9>&-
