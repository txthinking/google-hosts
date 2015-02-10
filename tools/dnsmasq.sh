#!/bin/bash
cat ../scripts/hosts.all | awk '{if(NF==2){ print "address=/"$2"/"$1}}' > ../google.dnsmasq.conf
