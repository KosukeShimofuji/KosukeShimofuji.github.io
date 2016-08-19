---
layout: post
title:  "ctf-bf-coreの開発記"
date:   2016-08-19 15:30:00 +0900
categories: Development
toc: true
---

# はじめに

以下のエントリにより、OpenStackとDockerの最低限のオペレーションとAPIの使い方が理解できてきた。

 * [OpenMultiStackというものを作りたい](https://kosukeshimofuji.jp/2016/07/26/OpenMultiStack/)
 * [OpenMultiStackというものを作りたいの続き](https://kosukeshimofuji.jp/2016/08/09/OpenMultiStack/)
 * [DockerコンテナにSSH接続する](https://kosukeshimofuji.jp/2016/08/18/Docker-SSH/)

これらの組み合わせを使うとプログラムで制御できるようになると、色々できることの幅が広がって楽しい。
本エントリではCTF用のの環境を構築するための仕組みを考えて実装してみる。

 * dockerhostの立ち上げ


{% ditaa %}
+--------+  Restful API  +-------------+ OpenStack API  +--------------------+
| Client |-------------->| ctf-bf-core |--------------->| openstack provider |
+--------+               +-------------+                +---------+----------+
                                                                  |
                                                        +---------+----------+
                                                        | openstack provider | 
                                                        +--------------------+
{% endditaa %}

 * docker containerの立ち上げ

{% ditaa %}
+--------+  Restful API  +-------------+ Docker API  +-----+-------+
| Client |-------------->| ctf-bf-core |------------>| docker-host |
+--------+               +-------------+             +-+---+----+--+
                                                       |   |    |
                                            +----------+   |    +-------+
                                            |              |            |
                                      +-----+-----+ +------+----+  +----+------+ 
                                      | container | | container |  | container |
                                      +-----------+ +-----------+  +-----------+
              
{% endditaa %}

# 開発環境の構築

```
$ git clone git@github.com:KosukeShimofuji/ctf-bf-core.git
$ cd ctf-bf-core/ansible
$ ansible-playbook -i development site.yml
```

# Pythonの開発環境の構築

 * python 3.5.1のセットアップ

```
$ pyenv install 3.5.1
$ pyenv virtualenv 3.5.1 ctf-bf-core
$ pyenv global ctf-bf-core
```

 * django関連のpythonモジュールをインストールする

```
$ pip install --upgrade pip
$ pip install django
$ pip install psycopg2 # djangoからpostgresqlを操作するために必要
$ pip install djangorestframework
$ pip install django-filter 
```

 * openstack client関連のpythonモジュールをインストールする

```
$ pip install python-openstackclient
$ pip install python-neutronclient
```

 * direnvのインストール

```
$ wget https://github.com/direnv/direnv/releases/download/v2.9.0/direnv.linux-amd64 -O direnv
$ chmod 700 direnv
$ mv direnv local/bin/
$ echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
```

# Djangoプロジェクトの作成と設定

```
$ git clone git@github.com:KosukeShimofuji/ctf-bf-core.git
$ cd ctf-bf-core
$ django-admin startproject django_project
$ tree
.
├── ansible
│   ├── Vagrantfile
│   ├── ansible.cfg
│   ├── development
│   ├── group_vars
│   │   └── all.yml
│   ├── host_vars
│   │   ├── OpenMultiStack.conoha
│   │   └── ctf-bf-core.test
│   ├── production
│   ├── roles
│   │   ├── apache
│   │   │   └── tasks
│   │   │       └── main.yml
│   │   ├── common
│   │   │   └── tasks
│   │   │       └── main.yml
│   │   ├── login_user
│   │   │   ├── files
│   │   │   │   ├── _bashrc
│   │   │   │   └── _vimrc
│   │   │   └── tasks
│   │   │       └── main.yml
│   │   ├── postgresql
│   │   │   ├── tasks
│   │   │   │   └── main.yml
│   │   │   └── vars
│   │   │       └── main.yml
│   │   └── python
│   │       └── tasks
│   │           └── main.yml
│   ├── site.yml
│   └── stage
└── django_project
    ├── django_project
    │   ├── __init__.py
    │   ├── settings.py
    │   ├── urls.py
    │   └── wsgi.py
    └── manage.py
                        
18 directories, 22 files
```


