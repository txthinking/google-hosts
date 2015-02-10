#!/bin/bash
cd ../
cd scripts
./select.sh
./apply.sh
cd ../
git add .
git commit -m 'update hosts'
git push origin master
