#!/usr/bin/env bash
#
# Author: cloud@txthinking.com
#

function getip(){
    echo -n $(dig +tcp $1 @8.8.8.8 | grep -E 'IN\s+?A'| tail -1 | awk '{printf("%s", $5)}');
}

for host in $(cat hosts.us | awk '{if($2) printf("%s\n", $2); else printf("%s\n", $1);}')
do
    ip=$(grep -E "$host" hosts.us | awk "{if(\$2==\"$host\") printf(\"%s\", \$1);}")
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

cp hosts.all ../hosts

