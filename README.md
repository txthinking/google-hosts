google-hosts
============

### 为什么有这个项目

因为我每天都要访问Google, 以及我的朋友们也会访问Google.<br/>
然而朋友们对其他更复杂的代理未做深入研究, 最简单方法便是帮他们修改 hosts.<br/>
网上其他 hosts 项目有时未能及时更新, 为了朋友们方便, 所以便弄了这个项目.<br/>
此项目参考了[smarthosts][smarthosts], [ipv6-hosts][ipv6-hosts].<br/>

IP不总是可用的, 因素可能是GFW封锁, Google IP变动.<br/>
另外Google的好多服务都已经不挂在北京的IP上了<br/>
你可以用此脚本自己去寻找可用IP.

***

### 脚本如何使用

直接使用DNS解析获取所有域名的IP(这个只能跳过DNS污染, 并不能保证IP是否被封锁)

```
$ cd google-hosts/scripts
$ make #结果会输出到google-hosts/hosts文件
```

查询某段IP详细信息(如:192.168.1.x)(这个可检测IP是否被封锁, 443端口是否被封锁)

```
$ cd google-hosts/scripts
$ ./getssl.sh 192.168.1
```

查询某段IP详细信息(如:192.168.x.x)

```
$ cd google-hosts/scripts
$ ./find.sh 192.168
```

输出的四个字段含义

| IP | LOSS | TIME | SSL |
| --- | --- | --- | --- |
| 此IP | 丢包率| PING值 | 可用ssl域名 |

另外获取Google IP段可供参考

```
$ nslookup -q=TXT _netblocks.google.com 8.8.8.8
```

***

下面的两个程序是用来将此项目内的hosts文件替换你系统hosts. 尤其是你的不懂程序的Windows朋友<br/>
**注意**: **如果**此项目下hosts文件内的IP失效, 就需要你自己用脚本查询了(如果你查到好的IP不妨pull一下 :D)<br/>

### Windows 用户如何使用

* 下载 <http://sh.txthinking.com/fuckGFW.exe> 双击执行即可
* 要更新的话, 也是双击执行
* 此程序不会覆盖你原有的 hosts

### *nix 用户如何使用

* 下载此脚本 [updateHosts.py][updateHosts.py]
* 执行 `$ sudo python updateHosts.py`
* 此程序不会覆盖你原有的 hosts

[smarthosts]: https://code.google.com/p/smarthosts/
[ipv6-hosts]: https://code.google.com/p/ipv6-hosts/
[updateHosts.py]: https://github.com/txthinking/google-hosts/tree/master/scripts/updateHosts.py
