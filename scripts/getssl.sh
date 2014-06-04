#!/usr/bin/env bash
#
# 会查询一个IP段的IP得到其 PINT值,丢报率,SSL域名
#
# EP: 查询192.168.1.x的IP
# $ cd scripts
# $ ./getssl.sh 192.168.1 
#
# Author: cloud@txthinking.com
#

if [ ! -d output ]
then
    mkdir output;
fi
output=output/$1.x;
> $output;
echo -e "IP\tLOSS\tTIME\tSSL"
for((i=0;i<255;i++))
do
    ip=${1}.${i};
    c=$(nmap --host-timeout 3s $ip -p 443 2>/dev/null | grep -Ec "443/tcp open");
    if [ $c -ne 1 ]
    then
        echo -e "$ip\tNO\tNO\tNO";
        echo -e "$ip\tNO\tNO\tNO" >> $output;
        continue;
    fi
    cer=$(curl https://$ip 2>&1 | grep -Eo "'\S*'" |head -1);
    if [ -z $cer ]
    then
        echo -e "$ip\tNO\tNO\tNO";
        echo -e "$ip\tNO\tNO\tNO" >> $output;
        continue;
    fi
    ping -c 5 -w 5 $ip > /tmp/ping;
    loss=$(grep -Eo "\w+%" /tmp/ping);
    c=$(grep -c "time=" /tmp/ping);
    if [ $c -eq 0 ]
    then
        echo -e "$ip\t$loss\tNO\t$cer";
        echo -e "$ip\t$loss\tNO\t$cer" >> $output;
        continue;
    fi
    avgtime=$(grep -E "time=" /tmp/ping | awk '{print $7}' | awk 'BEGIN {FS="=";s=0;c=0;}{s+=$2;c++;} END {print s/c}');
    echo -e "$ip\t$loss\t$avgtime\t$cer";
    echo -e "$ip\t$loss\t$avgtime\t$cer" >> $output;
done
sort -k4 -k3n $output -o $output;
sed -i "1iIP\tLOSS\tTIME\tSSL" $output;
cat $output;
echo "[INFO] Done in $output";

