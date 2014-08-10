google-hosts
============
[**授人以渔**][L0] | [**授人以鱼**][L1] | [**小技巧**][L2]
---

为什么有这个项目
---

因为我每天都要访问Google, 以及我的朋友们也会访问Google.<br/>
然而朋友们对其他更复杂的代理未做深入研究, 最简单方法便是帮他们修改 hosts.<br/>
于人于己方便, 便弄了这个项目. 包含了大部分Google服务, G+, Drive, Gmail, Hangouts, Calendar等<br/>
域名参考了[smarthosts][smarthosts], [ipv6-hosts][ipv6-hosts].<br/>

IP不总是可用的, 因素可能是GFW封锁或Google IP变动. <br/>
同一个IP, A省能连上, B省就可能连不上(网络封锁). 上一个小时能连上, 这一个小时连不上(间歇性阻断)<br/>
另外Google的好多服务都已经不挂在北京的IP上了<br/>

如何自己用程序找IP
---

**`find.sh`查询某段IP详细信息,可接受一个或多个参数(这个可检测IP是否被封锁, 443端口是否被封锁)**

```
$ cd google-hosts/scripts

# 查询 192.168.1.x
$ ./find.sh 192.168.1

# 查询 192.168.x.x
$ ./find.sh 192.168

# 查询 192.168.x.x, 192.169.x.x, 192.170.1.x
$ ./find.sh 192.168 192.169 192.170.1
```

**`filter.sh`从output目录(由find.sh生成)过滤域名**

```
$ cd google-hosts/scripts

# 过滤可用于*.google.com的域名
$ ./filter.sh *.google.com

# 过滤可用于mail.google.com的域名
$ ./filter.sh mail.google.com
```

**`use.sh`使用过滤出的某个IP并更新hosts.all文件**

```
$ cd google-hosts/scripts

# 使用可用于*.google.com 的IP 192.168.1.1
$ ./use.sh *.google.com 192.168.1.1

# 使用可用于mail.google.com 的IP 192.168.1.1
$ ./use.sh mail.google.com 192.168.1.1
```

**`select.sh`结合了filter.sh, use.sh,自动选择最佳IP写入hosts.all文件, 并做了些特殊域名处理**

```
$ cd google-hosts/scripts
$ ./select.sh
```

**`apply.sh`使用hosts.all文件更新../hosts文件**

```
$ cd google-hosts/scripts
$ ./apply.sh
```

**`auto.sh`结合了find.sh, select.sh, apply.sh自动查询后选择最佳IP写入../hosts文件**

```
$ cd google-hosts/scripts

# 查询192.168.x.x,192.169.1.x, 并在查询完后自动选择最佳IP更新../hosts文件
$ ./auto.sh 192.168 192.169.1
```

输出的四个字段含义

| IP | LOSS | TIME | SSL |
| --- | --- | --- | --- |
| 此IP | 丢包率| PING值 | 可用ssl域名 |

获取Google IP段可供参考

```
$ nslookup -q=TXT _netblocks.google.com 8.8.4.4
```

使用当前的[hosts][hosts]
---

> 如果此hosts文件内的IP失效, 就需要你自己用上面提到的脚本查询了<br/>
> 下面的程序不会覆盖你原有的hosts<br/>

**Windows 用户**

使用及更新: [fuckGFW-64.exe][fuckGFW-64.exe](64位) / [fuckGFW-32.exe][fuckGFW-32.exe](32位)双击运行

**\*nix/OSX 用户**

使用及更新: 打开终端运行`$ curl http://tx.txthinking.com/fuckGFW.py | sudo python`

小技巧
---

* 请使用国际版google. 防止google本地化重定向: 访问一下<https://www.google.com/ncr>
* 请使用`https`替代`http`访问.

Contributing
---

* vim:ts=4:sw=4:expandtab:ff=unix:encoding=utf8
* Please create your pull request on `develop` branch

License
---

Licensed under The [MIT][MIT] License

[hosts]: http://tx.txthinking.com/hosts
[fuckGFW-64.exe]: http://tx.txthinking.com/fuckGFW-64.exe
[fuckGFW-32.exe]: http://tx.txthinking.com/fuckGFW-32.exe
[smarthosts]: https://code.google.com/p/smarthosts/
[ipv6-hosts]: https://code.google.com/p/ipv6-hosts/
[L0]: #%E5%A6%82%E4%BD%95%E8%87%AA%E5%B7%B1%E7%94%A8%E7%A8%8B%E5%BA%8F%E6%89%BEip
[L1]: #%E4%BD%BF%E7%94%A8%E5%BD%93%E5%89%8D%E7%9A%84hosts
[L2]: #%E5%B0%8F%E6%8A%80%E5%B7%A7
[MIT]: https://github.com/txthinking/google-hosts/blob/master/LICENSE
