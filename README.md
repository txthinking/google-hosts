google-hosts
============

### 为什么有这个项目

因为我每天都要访问Google, 以及我的朋友们也会访问Google.<br/>
然而朋友们对其他更复杂的代理未做深入研究, 最简单方法便是修改 hosts.<br/>
网上其他 hosts 项目有时未能及时更新, 为了朋友们方便, 所以便弄了这个项目<br/>
此项目参考了[smarthosts][smarthosts], [ipv6-hosts][ipv6-hosts]<br/>

### Windows 用户如何使用

* 下载 <http://sh.txthinking.com/fuckGFW.exe> 双击执行即可
* 要更新的话, 也是双击执行
* 此程序不会覆盖你原有的 hosts

### *nix 用户如何使用

* 下载此脚本 [updateHosts.py][updateHosts.py]
* 执行 `$ sudo python updateHosts.py`
* 此程序不会覆盖你原有的 hosts

### MORE

获取Google IP段

```
$ nslookup -q=TXT _netblocks.google.com 8.8.8.8
```

查询某段IP是否可用(如:192.168.1.x)

```
$ scripts/getssl.sh 192.168.1
```

查询某段IP是否可用(如:192.168.x.x)

```
$ scripts/find.sh 192.168
```

输出的四个字段含义

| IP | LOSS | TIME | SSL |
| --- | --- | --- | --- |
| 此IP | 丢包率| PING值 | 可用ssl域名 |

[smarthosts]: https://code.google.com/p/smarthosts/
[ipv6-hosts]: https://code.google.com/p/ipv6-hosts/
[updateHosts.py]: https://github.com/txthinking/google-hosts/tree/master/scripts/updateHosts.py
