google-hosts
============

[How](#How) | [Must](#Must) | [Donate](#Donate)

**Notice: 每天2:00点自动更新**

How
---

### 使用当前的[hosts][hosts]

> 程序不会覆盖你原有的hosts<br/>
> 首次更新时会向hosts文件写入一行`#TX-HOSTS`, 请不要删除它

**Windows 用户**

0. 请先退出所有杀毒软件
1. Windows XP 以上请使用管理员身份运行或赋予hosts文件可写权限
2. 使用及更新: [fuckGFW-64.exe][fuckGFW-64.exe](64位) / [fuckGFW-32.exe][fuckGFW-32.exe](32位)双击运行

**\*nix/OSX 用户**

0. 打开终端
1. 使用及更新: `$ curl -s http://freedom.txthinking.com/fuckGFW.py | sudo python`
2. 输入当前用户密码并回车

### 自己查找hosts

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
$ ./auto.sh
```

输出的四个字段含义

| IP | LOSS | TIME | SSL |
| --- | --- | --- | --- |
| 此IP | 丢包率| PING值 | 可用ssl域名 |

Must
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

Donate
---

Alipay/Paypal: `cloud@txthinking.com`

[hosts]: http://freedom.txthinking.com/hosts
[fuckGFW-64.exe]: http://freedom.txthinking.com/fuckGFW-64.exe
[fuckGFW-32.exe]: http://freedom.txthinking.com/fuckGFW-32.exe
[MIT]: https://github.com/txthinking/google-hosts/blob/master/LICENSE
