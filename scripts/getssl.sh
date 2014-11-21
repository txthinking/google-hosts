#!/usr/bin/env bash
#
# 会查询一个IP段的IP得到其 PING值,丢包率,SSL可用于的域名
# 结果输出到output目录
#
# EP:
# 查询192.168.1.x的IP
# $ ./getssl.sh 192.168.1 
#
# Author: cloud@txthinking.com
#

if [ $# -eq 0 ]
then
    echo -e "Usage:\n"
    echo -e "    $ ./getssl.sh 192.168.1"
    echo -e "\nView getssl.sh file to see more.\n"
    exit 0
fi

if [ ! -d output ]
then
    mkdir output
fi
output=output/$1.x
> $output
echo -e "IP\tLOSS\tTIME\tSSL"
for((i=0;i<255;i++))
do
    ip=${1}.${i}
    c=$(nmap --host-timeout 2s $ip -p 443 2>/dev/null | grep -Pc "443/tcp open")
    if [ $c -ne 1 ]
    then
        echo -e "$ip\tNO\tNO\tNO"
        echo -e "$ip\tNO\tNO\tNO" >> $output
        continue
    fi
    cer=$(curl https://$ip 2>&1 | grep -Po "'\S*'" |head -1|cut -d \' -f 2)
    if [ -z $cer ]
    then
        echo -e "$ip\tNO\tNO\tNO"
        echo -e "$ip\tNO\tNO\tNO" >> $output
        continue
    fi
    ping=/tmp/ping-$ip
    ping -c 5 -w 5 $ip > $ping
    loss=$(grep -Po "\w+%" $ping)
    c=$(grep -c "time=" $ping)
    if [ $c -eq 0 ]
    then
        echo -e "$ip\t$loss\tNO\t$cer"
        echo -e "$ip\t$loss\tNO\t$cer" >> $output
        continue
    fi
    avgtime=$(grep -P "time=" $ping | awk '{print $7}' | awk 'BEGIN {FS="=";s=0;c=0;}{s+=$2;c++;} END {print s/c}')
    echo -e "$ip\t$loss\t$avgtime\t$cer"
    echo -e "$ip\t$loss\t$avgtime\t$cer" >> $output
done
sort -k4 -k2n -k3n $output -o $output
echo "[INFO] Done in $output"
