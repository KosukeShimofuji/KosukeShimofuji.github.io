---
layout: post
title:  "Windows環境のセットアップ"
date:   2016-07-05 00:00:00 +0900
categories: jekyll
---

何度もWindowsを作り直しているので環境構築の備忘録を残しておく。

## [Ctrl2Cap](https://technet.microsoft.com/ja-jp/sysinternals/bb897578.aspx)

caps lockをCtrlにする

## [Cygwin](https://cygwin.com/packages/)

Windowsにbash環境を構築するために使う。Bash on
Windowsもあるけど、使い慣れてるCygwinを今は選択している。

## apt-cyg

Cygwinでコンソールからパッケージを導入するために使用する。

```
$ wget https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg
$ chmod 700 apt-cyg
$ mkdir -p ~/local/bin/
$ mv apt-cyg ~/local/bin
$ apt-cyg -m ftp://ftp.iij.ad.jp/pub/cygwin/ update
```

## cocoto

cygwinからwindows標準のコマンドを実行すると文字化けするので、対策としてcocotoを導入する。

```
$ apt-cyg install libiconv libiconv-devel bind-utils git make gcc-core
$ git clone http://github.com/vmi/cocot
$ cd cocot
$ ./configure
$ make
$ make install
$ cocoto.exe ipconfig
```

## Cygwinでsudoを使えるようにする

```
cat > .bashrc
IF [[ -N "$ps1" ]]; THEN
    __SUDO_CYGWIN() {
    LOCAL EXECUTABLE=$(WHICH "${1:-CMD}")
    SHIFT
    /USR/BIN/CYGSTART --ACTION=RUNAS "$EXECUTABLE" "$@"
}

    IF [[ -X "/USR/BIN/CYGSTART" ]]; THEN
           ALIAS SUDO=__SUDO_CYGWIN
    FI
FI
```

## tmux

ターミナルマルチプレクサのtmuxを導入する。

```
apt-cyg install tmux
```

## vim 

```
mkdir -p ~/.vim/{swap,backup,colors,bundle}
git clone https://github.com/Shougo/neobundle.vim
```

## [Ricty Fonts](http://www.rs.tus.ac.jp/yyusa/ricty_diminished.html)

Fontを導入したら以下の場所にコピペする。

```
コントロール パネル\すべてのコントロール パネル項目\フォント
```


## [Virtualbox](https://www.virtualbox.org/wiki/Downloads) & [Vagrant](https://www.vagrantup.com/)

Widnowsをメインに使うけど、検証用マシンでLinuxが必要なのでVirtualboxとVagrantを導入する

## python2

ansibleを動作させるためにcygwin環境にpython2を構築する。ansibleはpython3では動作しないようだ。
pyenvとvirtualenvを使いたかったけどCygwin環境では使うことができなかった。

```
$ apt-cyg install python
```

## pip

```
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
```

## ansible

ansibleのに必要なcygwinパッケージを導入

```
apt-cyg install libffi-devel openssl-devel libgmp-devel
```

ansibleはosxやlinux環境ではpipで簡単に導入できるけど、windowsではpycryptoのビルドに失敗していたので、手動でインストールしてから導入する。

```
git clone https://github.com/dlitz/pycrypto
cd pycrypto
python setup.py build
python setup.py install
```

ansibleのインストール

```
pip install ansible
```

## 参考文献

 * http://hpcmemo.hatenablog.com/entry/2016/03/11/004541
 * qiita.com/konta220/items/95b40b4647a737cb51aa
 * http://yuukiar.co/blog/2015/04/04/windows-chocolatey/
 * http://inaz2.hatenablog.com/entry/2015/11/12/233356

