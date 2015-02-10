#!/bin/bash
cd ../scripts
./select.sh
./apply.sh
cd ../tools/
./dnsmasq.sh
cd ../
git add .
git commit -m 'update hosts'
git push origin master
