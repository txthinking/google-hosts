#!/usr/bin/env bash
# 
# 生成../google.dnsmasq.conf
#
# EP:
# $ ./dnsmasq google.com 192.168.1.1
#
# Author: cloud@txthinking.com
#

if [ $# -lt 2 ]
then
    echo -e "Usage:\n"
    echo -e "    $ ./dnsmasq.sh DOMAIN IP"
    echo -e "\nView dnsmasq.sh file to see more.\n"
    exit 0
fi

echo "address=/$1/$2" >> ../google.dnsmasq.conf
