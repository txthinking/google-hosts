#!/bin/bash
git pull origin master
cd ../scripts
./getip.sh
./apply.sh
cd ../
git add .
git commit -m 'update do'
git push origin master
