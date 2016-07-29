---
layout: post
title:  "パッチ情報を通知してくれる何かが欲しい"
date:   2016-07-28 14:56:00 +0900
categories: development
toc: true
---

脆弱性の評価を日常的に行っているんだけど、redhatやdebianからパッチが出るのは脆弱性の公表から数日ズレがある。
CVE番号を渡したら、対応するパッチ情報に更新があるかを調べて、更新がある時は通知してくれる簡単なツールがあれば便利だなと思った。
[vuls](https://github.com/future-architect/vuls/blob/master/README.ja.md)に影響されてgo言語を使いたくなったので、goの学習がてら作ってみる。

# tracve

以下ようなのセキュリティアドバイザリのページを監視して、更新があれば通知を行う。

 * [redhat](https://access.redhat.com/security/cve/CVE-2016-5734)
 * [debian](https://security-tracker.debian.org/tracker/CVE-2016-5734)
 * [ubuntu](https://people.canonical.com/~ubuntu-security/cve/CVE-2016-5734.html)

## Usage

 * トラッキングの開始

```
$ tracve add CVE-2016-5734
```

 * トラッキングの実行

```
$ tracve check
```

 * トラッキングの終了

```
$ tracve del CVE-2016-5734
```

 * トラッキング対象CVE一覧

```
$ tracve list
```

# Go言語の開発環境を構築

```
$ wget https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz
$ sudo tar -C /usr/local -xzf go1.6.linux-amd64.tar.gz
$ mkdir $HOME/go
$ cat /etc/profile.d/goenv.sh
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
$ source /etc/profile.d/goenv.sh
```

# GOのパッケージを作成

```
$ mkdir -p $GOPATH/src/github.com/KosukeShimofuji/tracve/
$ cd $GOPATH/src/github.com/KosukeShimofuji/tracve/
$ git init
Initialized empty Git repository in /home/kosuke/go/src/github.com/KosukeShimofuji/tracve/.git/
$ git remote add origin git@github.com:KosukeShimofuji/tracve.git
```

# コマンドラインオプションの作成

```
$ go get github.com/urfave/cli
```

# sqliteの連携

```
$ go get github.com/mattn/go-sqlite3
```

# 参考文献

 * http://qiita.com/futoase/items/73b7ca9fb16ca588ad6f
 * https://developers.eure.jp/tech/golang_commandlinetool/
 * https://github.com/mattn/go-sqlite3/blob/master/_example/simple/simple.go


