#!/bin/bash
git pull origin master
cd ../scripts
./getip.sh
./apply.sh
cd ../tools/
./dnsmasq.sh
cd ../
git add .
git commit -m 'update do and dnsmasq'
git push origin master
