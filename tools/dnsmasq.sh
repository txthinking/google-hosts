#!/bin/bash
cat ../scripts/hosts.all | awk '{print "address=/"$2"/"$1}' > ../google.dnsmasq.conf
