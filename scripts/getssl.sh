#!/usr/bin/env bash
#
#会查询IP得到其 PING值,丢包率,SSL可用于的域名
#
# EP:
# 查询192.168.1.1
# $ ./getssl.sh 192.168.1.1
#
# Author: cloud@txthinking.com
#

if [ $# -eq 0 ]
then
    echo -e "Usage:\n"
    echo -e "    $ ./getssl.sh 192.168.1.1"
    echo -e "\nView getssl.sh file to see more.\n"
    exit 0
fi

ip=${1}
c=$(nmap --host-timeout 2s $ip -p 443 2>/dev/null | grep -Pc "443/tcp open")
if [ $c -ne 1 ]
then
    echo -e "$ip\tNO\tNO\tNO"
    exit 0
fi
cer=$(curl https://$ip 2>&1 | grep -Po "'\S*'" |head -1|cut -d \' -f 2)
if [ -z $cer ]
then
    echo -e "$ip\tNO\tNO\tNO"
    exit 0
fi
ping=/tmp/ping-$ip
ping -c 5 -w 5 $ip > $ping
loss=$(grep -Po "\w+%" $ping)
c=$(grep -c "time=" $ping)
if [ $c -eq 0 ]
then
    echo -e "$ip\t$loss\tNO\t$cer"
    exit 0
fi
avgtime=$(grep -P "time=" $ping | awk '{print $7}' | awk 'BEGIN {FS="=";s=0;c=0;}{s+=$2;c++;} END {print s/c}')
echo -e "$ip\t$loss\t$avgtime\t$cer"
