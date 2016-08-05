---
layout: post
title:  "OpenStack Python SDKを使ってみる"
date:   2016-08-05 10:00:00 +0900
categories: development
toc: true
---

OpenStackにはPythonのSDKが存在するため、PythonからOpenStackを操作する際はRestful apiを叩くより、SDKを使ったほうが楽だそうです。

# 開発環境の構築

python openstack sdkのインストール方法については[ここ](http://docs.openstack.org/ja/user-guide/common/cli_install_openstack_command_line_clients.html)で詳細に説明されています。

 * build python 3.5.1 envrionment 

```
$ pyenv install 3.5.1
$ pyenv virtualenv 3.5.1 OpenStackSDK
$ pyenv global OpenStackSDK
$ pip install --upgrade pip
```

 * build direnv environment

```
$ wget https://github.com/direnv/direnv/releases/download/v2.9.0/direnv.linux-amd64 -O direnv
$ chmod 700 direnv
$ mv direnv local/bin/
$ echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
$ pip install python-openstackclient python-neutronclient
```

 * install OpenStack python sdk

```
$ pip install python-openstackclient python-neutronclient
```

# Conoha用のenvrcを用意する

```
$ git clone git@github.com:KosukeShimofuji/conoha-sandbox.git
$ cat > .envrc
export OS_TENANT_NAME="SECRET"
export OS_USERNAME="SECRET"
export OS_PASSWORD="SECRET"
export OS_AUTH_URL="https://identity.tyo1.conoha.io/v2.0"
export OS_REGION_NAME="tyo1"
CTRL+C
$ direnv allow
``` 

# [nova](http://docs.openstack.org/developer/nova/)

## 認証用の関数

credentials.pyにまとめて使う

```python
import os

def get_neutron_credentials():
    d = {}
    d['username'] = os.environ['OS_USERNAME']
    d['password'] = os.environ['OS_PASSWORD']
    d['auth_url'] = os.environ['OS_AUTH_URL']
    d['tenant_name'] = os.environ['OS_TENANT_NAME']
    d['region_name'] = os.environ['OS_REGION_NAME']
    return d

def get_nova_credentials():
    d = {}
    d['version'] = '2'
    d['username'] = os.environ['OS_USERNAME']
    d['api_key'] = os.environ['OS_PASSWORD']
    d['auth_url'] = os.environ['OS_AUTH_URL']
    d['project_id'] = os.environ['OS_TENANT_NAME']
    d['region_name'] = os.environ['OS_REGION_NAME']
    return d
```

## サーバ一覧表示

```python
#!/usr/bin/env python
from credentials import get_nova_credentials
from novaclient.client import Client

credentials = get_nova_credentials()
nova_client = Client(**credentials)

print(nova_client.servers.list())
```

## サーバの作成

```python
#!/usr/bin/env python
import time
from credentials import get_nova_credentials
from novaclient.client import Client

credentials = get_nova_credentials()
nova_client = Client(**credentials)

image = nova_client.images.find(name="vmi-debian-8-amd64")
flavor = nova_client.flavors.find(name="g-1gb")
instance = nova_client.servers.create(
    name="test",
    image=image,
    flavor=flavor
)

# Poll at 5 second intervals, until the status is no longer 'BUILD'
status = instance.status
while status == 'BUILD':
    time.sleep(5)
    # Retrieve the instance again so the status field updates
    instance = nova_client.servers.get(instance.id)
    status = instance.status
print("status: %s" % status)
```

## すべてのサーバを削除

```python
#!/usr/bin/env python
from credentials import get_nova_credentials
from novaclient.client import Client

credentials = get_nova_credentials()
nova_client = Client(**credentials)

servers = nova_client.servers.list()
for i in servers:
    nova_client.servers.delete(i.id)
```

# 参考文献

 * http://docs.openstack.org/ja/user-guide/sdk.html
 * http://qiita.com/makisyu/items/736ecb82757fb995f0f6
 * https://www.ibm.com/developerworks/jp/cloud/library/cl-openstack-pythonapis/

