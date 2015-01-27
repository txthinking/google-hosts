#!/bin/bash
cd ../
git checkout develop
cd scripts
./select.sh
./apply.sh
cd ../
git add .
git commit -m 'update'
git push origin develop
git checkout master
git merge develop
git push origin master
git checkout develop
