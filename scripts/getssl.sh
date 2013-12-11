#!/usr/bin/env bash
#
# Author: cloud@txthinking.com
#
# param $1 like "192.168.1"
#
> /tmp/getssl-$1;
for((i=0;i<255;i++))
do
    ip=${1}.${i};
    c=$(nmap --host-timeout 3s $ip -p 443 | grep -Ec "443/tcp open");
    if [ $c -ne 1 ]
    then
        echo -e "$ip\tNO\tNO\tNO" >> /tmp/getssl-$1;
        continue;
    fi
    cer=$(curl https://$ip 2>&1 | grep -Eo "'\S*'" |head -1);
    if [ -z $cer ]
    then
        echo -e "$ip\tNO\tNO\tNO" >> /tmp/getssl-$1;
        continue;
    fi
    ping -c 5 -w 5 $ip > /tmp/ping;
    loss=$(grep -Eo "\w+%" /tmp/ping);
    c=$(grep -c "time=" /tmp/ping);
    if [ $c -eq 0 ]
    then
        echo -e "$ip\t$loss\tNO\t$cer" >> /tmp/getssl-$1;
        continue;
    fi
    avgtime=$(grep -E "time=" /tmp/ping | awk '{print $7}' | awk 'BEGIN {FS="=";s=0;c=0;}{s+=$2;c++;} END {print s/c}');
    echo -e "$ip\t$loss\t$avgtime\t$cer" >> /tmp/getssl-$1;
done
echo -e "IP\tLOSS\tTIME\tSSL";
sort -k4 -k3n /tmp/getssl-$1 > /tmp/getssl-$1;

