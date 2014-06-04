'''
File: updateHosts.py
Author: cloud@txthinking.com
Version: 0.0.1
Date: 2012-10-24 14:35:39
'''

import urllib
import os

def GetRemoteHosts(hostsUrl):
    fp = urllib.urlopen(hostsUrl)
    hosts = [line for line in fp]
    fp.close()
    return hosts

if __name__ == "__main__":
    hosts = GetRemoteHosts("http://tx.txthinking.com/hosts")
    hostsPath = "/etc/hosts"

    search = "#GOOGLE-HOSTS\n"
    yourHosts = ""
    fp = open(hostsPath, "r")
    while 1:
        line = fp.readline()
        if line == search or line == "":
            break
        yourHosts += line
    yourHosts += search
    fp.close()

    os.rename(hostsPath, hostsPath + ".BAK")

    fp = open(hostsPath, "w")
    fp.write(yourHosts)
    fp.writelines(hosts) #iterable sequence hosts
    fp.close()

    print "Success"

