#!/usr/bin/env bash
#
# 此会遍历hosts.do里面的域名并查询dns解析出的IP(如果域名前面已经写有IP则跳过查询)
# 此脚本并不会检查解析到的IP是否被GFW封锁或封锁443端口, 可移步find.sh查询
#
# Author: cloud@txthinking.com
#

function getip(){
    times=0;
    until [ `echo $ip | grep -Pc "^(173|60|74)"` -eq 1 ]
    do
        ip=$(dig +tcp $1 @208.67.220.220 | grep -P 'IN\s+?A'| tail -1 | awk '{printf("%s", $5)}')
        times=$(($times+1))
        if [ $times -eq 20 ]
        then
            break
        fi
    done
    echo -n $ip;
}

for host in $(cat hosts.do | awk '{if($2) printf("%s\n", $2); else printf("%s\n", $1);}')
do
    ip=$(grep -P "$host" hosts.do | awk "{if(\$2==\"$host\") printf(\"%s\", \$1);}")
    if [ -z $ip ]
    then
        ip=$(getip $host)
    fi

    if [ -z $ip ]
    then
        echo "[WARNING] $host"
        continue;
    fi
    output="$ip    $host"
    echo $output
    sed -i -r "s/.*?    $host/$output/" hosts.all
done
