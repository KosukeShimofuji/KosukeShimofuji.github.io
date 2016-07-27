---
layout: post
title:  "vulsを触ってみる"
date:   2016-07-26 15:00:00 +0900
categories: tools
toc: true
---

[vuls](https://github.com/future-architect/vuls/blob/master/README.ja.md)を自社サービスに導入可能かを検討するために調査を行います。着目する点は導入した際のメリット・デメリット、及び導入・運用のしやすさです。vulsはdockerで簡単に立ち上げることができるようですが、実装についても興味がありますのでここでは[README](https://github.com/future-architect/vuls/blob/master/README.ja.md)に沿って手動でインストールを行い理解を深めます。

# 手動でインストールしてみる

 * 検証環境

```
kosuke@vuls ~ $ lsb_release -a
No LSB modules are available.
Distributor ID: Debian
Description:    Debian GNU/Linux 8.5 (jessie)
Release:        8.5
Codename:       jessie
```

## 自分自身にSSH接続できるようにする

この作業は自分自身をscanするために必要な作業です。

```
kosuke@vuls ~ $ ssh-keygen -t rsa
kosuke@vuls ~ $ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
kosuke@vuls ~ $ chmod 600 ~/.ssh/authorized_keys
```

## Buildに必要なソフトウェアをインストールする

```
kosuke@vuls ~ $ sudo apt-get install gcc sqlite3 git
kosuke@vuls ~ $ wget https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz
kosuke@vuls ~ $ sudo tar -C /usr/local -xzf go1.6.linux-amd64.tar.gz
kosuke@vuls ~ $ mkdir $HOME/go
```

go環境の設定を行う。/etc/profile.d/goenv.shを作成しsourceコマンドで読み込んでおく。

```
kosuke@vuls ~ $ cat /etc/profile.d/goenv.sh
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
kosuke@vuls ~ $ source /etc/profile.d/goenv.sh
```

## [go-cve-dictionary](https://github.com/kotakanbe/go-cve-dictionary)のデプロイ

```
kosuke@vuls ~ $ sudo mkdir /var/log/vuls
kosuke@vuls ~ $ sudo chmod 700 /var/log/vuls
kosuke@vuls ~ $ sudo chown kosuke /var/log/vuls/
kosuke@vuls ~ $ go get github.com/kotakanbe/go-cve-dictionary
```

脆弱性データベースの取得を行う。手元のvagrant環境ではこの作業に4時間かかった。

```
kosuke@vuls ~ $ for i in {2002..2016}; do go-cve-dictionary fetchnvd -years $i; done
...snip...
kosuke@vuls ~ $ ls -alh cve.sqlite3
-rw-r--r-- 1 kosuke kosuke 555M  7月 27 14:54 cve.sqlite3
```

## vulsのデプロイ

```
kosuke@vuls ~ $ go get github.com/future-architect/vuls
```

## Configを作成

```
kosuke@vuls ~ $ cat config.toml
[servers]

[servers.127-0-0-1]
host         = "127.0.0.1"
port        = "22"
user        = "kosuke"
keyPath     = "/home/kosuke/.ssh/id_rsa"
kosuke@vuls ~ $ vuls configtest
[Jul 27 15:50:09]  INFO [localhost] Validating Config...
[Jul 27 15:50:09]  INFO [localhost] Detecting Server/Contianer OS...
[Jul 27 15:50:09]  INFO [localhost] Detecting OS of servers...
[Jul 27 15:50:09]  INFO [localhost] (1/1) Detected: 127-0-0-1: debian 8.5
[Jul 27 15:50:09]  INFO [localhost] Detecting OS of containers...
[Jul 27 15:50:09]  INFO [localhost] SSH-able servers are below...
127-0-0-1
```

## ターゲットサーバの事前準備

```
kosuke@vuls ~ $ vuls prepare
INFO[0000] Start Preparing (config: /home/kosuke/config.toml)
[Jul 27 15:51:03]  INFO [localhost] Detecting OS...
[Jul 27 15:51:03]  INFO [localhost] Detecting OS of servers...
[Jul 27 15:51:03]  INFO [localhost] (1/1) Detected: 127-0-0-1: debian 8.5
[Jul 27 15:51:03]  INFO [localhost] Detecting OS of containers...
[Jul 27 15:51:03]  INFO [localhost] SSH-able servers are below...
127-0-0-1
[Jul 27 15:51:03]  INFO [localhost] Installing...
[Jul 27 15:51:03]  INFO [127-0-0-1] apt-get update...
[Jul 27 15:51:18]  INFO [127-0-0-1] Installed: aptitude
[Jul 27 15:51:18]  INFO [localhost] Success
```

## スキャンの開始

```
kosuke@vuls ~ $ vuls scan -cve-dictionary-dbpath=$PWD/cve.sqlite3
INFO[0000] Start scanning
INFO[0000] config: /home/kosuke/config.toml
INFO[0000] cve-dictionary: /home/kosuke/cve.sqlite3
[Jul 27 15:52:24]  INFO [localhost] Validating Config...
[Jul 27 15:52:24]  INFO [localhost] Detecting Server/Contianer OS...
[Jul 27 15:52:24]  INFO [localhost] Detecting OS of servers...
[Jul 27 15:52:24]  INFO [localhost] (1/1) Detected: 127-0-0-1: debian 8.5
[Jul 27 15:52:24]  INFO [localhost] Detecting OS of containers...
[Jul 27 15:52:24]  INFO [localhost] SSH-able servers are below...
127-0-0-1
[Jul 27 15:52:24]  INFO [localhost] Detecting Platforms...
[Jul 27 15:52:27]  INFO [localhost] (1/1) 127-0-0-1 is running on other
[Jul 27 15:52:27]  INFO [localhost] Scanning vulnerabilities...
[Jul 27 15:52:27]  INFO [localhost] Check required packages for scanning...
[Jul 27 15:52:27]  INFO [localhost] Scanning vulnerable OS packages...
[Jul 27 15:52:36]  INFO [127-0-0-1] Fetching CVE details...
[Jul 27 15:52:36]  INFO [127-0-0-1] Done
[Jul 27 15:52:36]  INFO [localhost] Scanning vulnerable software specified in the CPE...
[Jul 27 15:52:36]  INFO [localhost] Insert to DB...
[Jul 27 15:52:36]  INFO [localhost] Reporting...

127-0-0-1 (debian8.5)
=====================
No unsecure packages.
```

# 脆弱なサーバを用意する

vulsの対応しているOSは以下なので、この中から脆弱なサーバを作成する。

| Distribution|            Release |
|------------|-------------------|
| Ubuntu      |          12, 14, 16|
| Debian      |                7, 8|
| RHEL        |          4, 5, 6, 7|
| CentOS      |             5, 6, 7|
| Amazon Linux|                 All|
| FreeBSD     |                  10|

脆弱なサーバは[box-cutter](https://vagrantcloud.com/box-cutter)から用意する。意図的にパッケージをupgradeしないことで脆弱な状態が作り出せるはずだ。以下のboxを選んで4台構築する。

 * [ubuntu1204-i386](https://vagrantcloud.com/box-cutter/boxes/ubuntu1204-i386)
 * [debian81](https://vagrantcloud.com/box-cutter/boxes/debian81)
 * [centos510](https://vagrantcloud.com/box-cutter/boxes/centos510)
 * [freebsd102](https://vagrantcloud.com/box-cutter/boxes/freebsd102)

このような[Vagrantfile](https://github.com/KosukeShimofuji/vuls-envrionment/blob/27f32e2c8a9c1ee506c0092e4d2949b0d267c207/ansible/Vagrantfile)を用意して一気にHostを立ち上げる。作成された脆弱なホストとIPアドレスの対応は以下の通り。

| Hostname      | IP Address     |
|------------|-------------------|
| ubuntu1204-i386.test|192.168.10.108|
| debian81.test |192.168.10.109|
| centos510.test | 192.168.10.110|
| freebsd102.test |192.168.10.111|

それぞれのホストにvulsがSSH接続できるように公開鍵の設定を行う。

```
$ vagrant ssh ubuntu1204-i386.test
vagrant@vagrant:~$ cat >> .ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbGxMzWGY7vmBb2CsUoLQ7OTM3ulKZ9D5CQJRcCxw6/4+4aLiqAg2r4DEvmwb1LvG7mjCSysKe+0Df2mYkNMzdobYKMWYxh7D33o4vSJnfFWOp0CGqbmR+R9D7T3YS5h0jOE7JpQ+boe/kLwDib5tTtglg9qKobJjfysISTatp7/zhJ9gBrrM/pbLfBiReVH4h+iHOHPSpSDmppnyMsC7pSPvcyFN8St2PrKeDhCO1JkGitFKUXZSK4DKLnXpsBF3Ls0Ydco/9TxJW95/Owh/UVczs+vBPBMGHAay3L4czQlVMNJK0Lp1HvGSRr3ClT9rNdPpWlDbMcHVK+Ln+XQYZ kosuke@vuls.test
^C
```

ちなみにcentos510.testは起動時にnicの立ち上げに失敗したので、vagrant sshでログインしてから/sbin/ifup eth1してnicを立ち上げる必要があった。

```
# Down the interface before munging the config file. This might
# fail if the interface is not actually set up yet so ignore
# errors.
/sbin/ifdown '' || true

# Move new config into place
mv '/tmp/vagrant-network-entry--1469611151-0' '/etc/sysconfig/network-scripts/ifcfg-'

# Bring the interface up
ARPCHECK=no /sbin/ifup ''


Stdout from the command:



Stderr from the command:

usage: ifdown <device name>
Usage: ifup <device name>

$ vagrant ssh centos510.test
$ sudo -s 
# /sbin/ifup eth1
# /sbin/ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 08:00:27:07:F4:A9
          inet addr:192.168.10.110  Bcast:192.168.10.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fe07:f4a9/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:23 errors:0 dropped:0 overruns:0 frame:0
          TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2052 (2.0 KiB)  TX bytes:720 (720.0 b)
```

## Configに脆弱なサーバを加える

```
kosuke@vuls ~ $ cat config.toml
[servers]

[servers.vuls]
host         = "127.0.0.1"
port        = "22"
user        = "kosuke"
keyPath     = "/home/kosuke/.ssh/id_rsa"

[servers.ubuntu1204-i386]
host         = "192.168.10.108"
port        = "22"
user        = "kosuke"
keyPath     = "/home/kosuke/.ssh/id_rsa"

[servers.debian81]
host         = "192.168.10.109"
port        = "22"
user        = "kosuke"
keyPath     = "/home/kosuke/.ssh/id_rsa"

[servers.centos510]
host         = "192.168.10.110"
port        = "22"
user        = "kosuke"
keyPath     = "/home/kosuke/.ssh/id_rsa"

[servers.freebsd102]
host         = "192.168.10.111"
port        = "22"
user        = "kosuke"
keyPath     = "/home/kosuke/.ssh/id_rsa"
```

## スキャンの開始

```
kosuke@vuls ~ $ vuls scan -cve-dictionary-dbpath=$PWD/cve.sqlite3
...snip...
[Jul 27 18:47:12] ERROR [centos510] yum-changelog is not installed
[Jul 27 18:47:12] ERROR [localhost] Please execute with [prepare] subcommand to install required packages before scanning
[Jul 27 18:47:12] ERROR [localhost] Failed to scan. err: vagrant@192.168.10.110:22: yum-changelog is not installed
```

centosにはyum-changelogが必要のようだ。centosにyum-changelogを導入して再実行する。

[実行ログ](https://gist.github.com/KosukeShimofuji/4f96bf2336737bf51c484e194f60a5aa)

## スキャン結果の閲覧

ログだけでは俯瞰しにくいが、vulsはCUIの俯瞰できる画面を持っている。

```
kosuke@vuls ~ $ vuls tui
```

![vuls_tui]({{site.baseurl}}/images/2016/07/27/vuls_tui.gif)


# 参考文献

 * https://github.com/future-architect/vuls/blob/master/README.ja.md
 * http://qiita.com/tags/vuls/stocks
 * https://www.ipa.go.jp/security/vuln/CPE.html


