#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
Update hosts for *nix
Author: cloud@txthinking.com
Version: 0.0.1
Date: 2012-10-24 14:35:39
'''

import urllib2
import os
import sys

HOSTS_PATH = "/etc/hosts"
HOSTS_SOURCE = "http://tx.txthinking.com/hosts"
SEARCH_STRING = "#TX-HOSTS"

def GetRemoteHosts(url):
    f = urllib2.urlopen(url, timeout=5)
    hosts = [line for line in f]
    f.close()
    return hosts

def main():
    try:
        hosts = GetRemoteHosts(HOSTS_SOURCE)
    except IOError:
        print "Could't connect to %s. Try again." % HOSTS_SOURCE
        sys.exit(1)

    yours = ""
    if os.path.isfile(HOSTS_PATH):
        f = open(HOSTS_PATH, "r")
        for line in f:
            if SEARCH_STRING in line:
                break
            yours += line
        f.close()
        os.rename(HOSTS_PATH, HOSTS_PATH + ".BAK")
    yours += SEARCH_STRING + "\n"

    fp = open(HOSTS_PATH, "w")
    fp.write(yours)
    fp.writelines(hosts)
    fp.close()

    print "Success"

if __name__ == "__main__":
    main()
