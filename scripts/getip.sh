#!/usr/bin/env bash
#
# Author: cloud@txthinking.com
#

function getip(){
    times=0;
    until [ `echo $ip | grep -Ec "^(173|60|74)"` -eq 1 ]
    do
        ip=$(dig +tcp $1 @168.95.1.1 | grep -E 'IN\s+?A'| tail -1 | awk '{printf("%s", $5)}');
        times=$(($times+1));
        if [ $times -eq 20 ]
        then
            break;
        fi
    done
    echo -n $ip;
}

for host in $(cat hosts.do | awk '{if($2) printf("%s\n", $2); else printf("%s\n", $1);}')
do
    ip=$(grep -E "$host" hosts.do | awk "{if(\$2==\"$host\") printf(\"%s\", \$1);}")
    if [ -z $ip ]
    then
        ip=$(getip $host);
    fi

    if [ -z $ip ]
    then
        echo "[WARNING] $host";
        continue;
    fi
    output="$ip    $host";
    sed -r "s/.*?    $host/$output/" hosts.all > _hosts.all && mv _hosts.all hosts.all;
done

