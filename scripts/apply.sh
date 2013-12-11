#!/usr/bin/env bash
#
# Author: cloud@txthinking.com
#

> ../hosts
echo "#" >> ../hosts
echo "# link: https://github.com/txthinking/google-hosts" >> ../hosts
echo "#" >> ../hosts
echo "# UPDATE: `date -u`" >> ../hosts
echo "#" >> ../hosts
cat hosts.all >> ../hosts

