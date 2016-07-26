---
layout: post
title:  "vuls"
date:   2016-07-26 15:00:00 +0900
categories: tools
toc: true
---

[vuls](https://github.com/future-architect/vuls/blob/master/README.ja.md)を自社サービスに導入可能かを検討するために調査を行います。dockerで簡単に立ち上げることができるようですが、中身についても興味がありますのでここでは[README](https://github.com/future-architect/vuls/blob/master/README.ja.md)に沿って手動でインストールします。

# 手動でインストール

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

# [go-cve-dictionary](https://github.com/kotakanbe/go-cve-dictionary)のデプロイ


# 参考文献

 * https://github.com/future-architect/vuls/blob/master/README.ja.md
 * http://qiita.com/tags/vuls/stocks
 * https://www.ipa.go.jp/security/vuln/CPE.html


