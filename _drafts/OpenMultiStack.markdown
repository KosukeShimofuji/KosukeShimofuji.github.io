---
layout: post
title:  "OpenMultiStackというものを作りたい"
date:   2016-07-21 17:00:00 +0900
categories: python, development, django
toc: true
---

事情があってインスタンスを同時に100台程度稼働させたい。インスタンスの稼働時間は30-60分程度になる想定。じゃあOpenStackの出番だろうと思ってたら、著名なopenstack providerには最大20インスタンスしか同時に立ち上げられないような制限が入っていることに気づいた。openstackプロトコル自体は互換性があるんだから、openstack providerは複数にまたがって使えるよなあっていうのことでOpenMultiStackというのを作ってみたいと思う。
openstackの操作にはpython-openstackclientを使いたいので、API側も親和性が高いだろうということでdjangoを採用する。djangoを触ること自体が初めてなので、丁寧にドキュメントを残すことにする。

# 機能

 * OpenStack Providerのアカウントの集約
 * インスタンス情報を保持
 * WebインターフェイスからOpenStack Providerのアカウント登録できる
 * Webインターフェイスからインスタンス情報を俯瞰できる
 * いずれかのOpenStack Providerにメンテナンスや不具合があったとしても他のOpenStack Providerを使って可能な限り確実にインスタンスを立ち上げるように努力する
 * RESTful API

# 開発環境の構築

 * Python 3.5.1環境を構築

```
$ pyenv install 3.5.1
$ pyenv virtualenv 3.5.1 OpenMultiStack
$ pyenv global OpenMultiStack
```

 * django関連のモジュールをインストール

```
$ pip install --upgrade pip
$ pip install django
$ pip install psycopg2 # djangoからpostgresqlを操作するために必要
$ pip install djangorestframework
$ pip install django-filter 
```

 * openstack client関連のモジュールをインストール

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

# djangoプロジェクトの作成と設定

djangoには枠組みとしてプロジェクトとアプリケーションがあります。アプリケーションはBLOGやデータベースのレコード公開などの実際のwebアプリケーションを指します。プロジェクトはwebアプリケーションを構築するための設定やアプリケーションを集めたものです。プロジェクトには複数のアプリケーションを格納することができ、1つのアプリケーションは複数のプロジェクトから使用されることができます。

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack $ git checkout -b
OpenMultiStack
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack $ django-admin startproject django_project
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack $ tree django_project/
django_project/
├── django_project
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
└── manage.py

1 directory, 5 files
```

## TIMEZONEの変更を行う

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/be65ad68abe7097d7c3f592f5124e0622bd38331)

# djangoテストサーバの起動

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py runserver 0.0.0.0:8000
```

![django_test_server]({{site.baseurl}}/images/2016/07/22/django_test_server.png)

## backendデータベースにPostgresqlを利用するようにdjangoを設定する

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/d64b2783aad13bd8f690cce34f016597a94fb726)

# djangoアプリケーションの精査

django_project/settings.pyの中には以下のようなdjangoアプリケーションに関わる記述がある。

```
# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```

djangoアプリケーションはdjangoの機能を拡張するものだが、一つのアプリケーションに対して一つのデータベースのテーブルを使うらしい。不要なアプリケーションは除外しておく。

## migrateの実行

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Rendering model states... DONE
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying sessions.0001_initial... OK
```

migrateより以下のテーブルが作成されたことが確認できます。

```
django=> \dt
                    リレーションの一覧
 スキーマ |            名前            |    型    | 所有者
----------+----------------------------+----------+--------
 public   | auth_group                 | テーブル | django
 public   | auth_group_permissions     | テーブル | django
 public   | auth_permission            | テーブル | django
 public   | auth_user                  | テーブル | django
 public   | auth_user_groups           | テーブル | django
 public   | auth_user_user_permissions | テーブル | django
 public   | django_admin_log           | テーブル | django
 public   | django_content_type        | テーブル | django
 public   | django_migrations          | テーブル | django
 public   | django_session             | テーブル | django
(10 行)
```

# アプリケーションの作成

OpenMultiStackというdjangoアプリケーションを作成していきます。

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py startapp open_multi_stack
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ tree open_multi_stack/
open_multi_stack/
├── __init__.py
├── admin.py
├── apps.py
├── migrations
│   └── __init__.py
├── models.py
├── tests.py
└── views.py

1 directory, 7 files
```

## コントーラーとビューの定義

urls.pyを修正してコントーラーを定義し、views.pyを追加してビューを定義します。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/c9427133695019e6b19804aeebc264d1a74a183b)

```
$ curl http://OpenMultiStack.test:8000
Hello, world. You're at the first_app index.
```

## モデルの定義


OpenStackを利用する際にenvrcに以下のような情報を定義します。

```
export OS_TENANT_NAME="STRINGS"
export OS_USERNAME="STRINGS"
export OS_PASSWORD="STRINGS"
export OS_AUTH_URL="https://identity.hogehoge.com/v2.0"
export OS_REGION_NAME="tokyo"
```

これと同じ情報を格納できるモデルを定義します。ついでにこのアカウントを使うのか使わないのかを決定するフラグも追加しておきます。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/e1370534871eb4c0216d1467ab4ff4ca1aaf4e36)

## モデルの有効化

モデルの有効化によりdjangoはモデルに沿ったcreate tableの実行と、テーブルへのアクセスを行うapiの作成を自動的に行うことができます。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/be9d7c683e1caba303a14b45262c83b377011ebe)

## migration用のスクリプトの生成

migration用のスクリプトを生成します。

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py makemigrations open_multi_stack
Migrations for 'open_multi_stack':
  0001_initial.py:
    - Create model open_stack_account
```

生成されたスクリプトを中身を見てみましょう。

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ cat open_multi_stack/migrations/0001_initial.py
# -*- coding: utf-8 -*-
# Generated by Django 1.9.8 on 2016-07-22 06:43
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Account',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=128)),
                ('tenantname', models.CharField(max_length=128)),
                ('tenant_id', models.CharField(max_length=128)),
                ('password', models.CharField(max_length=128)),
                ('auth_url', models.CharField(max_length=128)),
                ('version', models.CharField(max_length=128)),
                ('status', models.CharField(choices=[('available', '使用可能'), ('unavailable', '使用不可')], default='available', max_length=12)),
                ('provider', models.CharField(max_length=128)),
            ],
        ),
    ]
```

モデルで定義した通りのテーブルを生成するスクリプト担っていることがわかります。

## 発行されるSQLの確認

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py sqlmigrate open_multi_stack 0001
BEGIN;
--
-- Create model Account
--
CREATE TABLE "open_multi_stack_account" ("id" serial NOT NULL PRIMARY KEY, "username" varchar(128) NOT NULL, "tenantname" varchar(128) NOT NULL, "tenant_id" varchar(128) NOT NULL, "password" varchar(128) NOT NULL, "auth_url" varchar(128) NOT NULL, "version" varchar(128) NOT NULL, "status" varchar(12) NOT NULL, "provider" varchar(128) NOT NULL);

COMMIT;
```

## migrateの実行

migrateの実行

```
$  python manage.py migrate
Operations to perform:
  Apply all migrations: contenttypes, auth, admin, open_multi_stack, sessions
Running migrations:
  Rendering model states... DONE
  Applying open_multi_stack.0001_initial... OK
```

migrateにより作成されたテーブルを確認する

```
django=> \d open_multi_stack_account
                                 テーブル "public.open_multi_stack_account"
     列     |           型           |                                修飾語
------------+------------------------+-----------------------------------------------------------------------
 id         | integer                | not null default nextval('open_multi_stack_account_id_seq'::regclass)
 username   | character varying(128) | not null
 tenantname | character varying(128) | not null
 tenant_id  | character varying(128) | not null
 password   | character varying(128) | not null
 auth_url   | character varying(128) | not null
 version    | character varying(128) | not null
 status     | character varying(12)  | not null
 provider   | character varying(128) | not null
インデックス:
    "open_multi_stack_account_pkey" PRIMARY KEY, btree (id)
```

## モデルの修正のフロー

 * models.pyを修正する
 * makemigrationsを実行してテーブル生成用スクリプトを作成する
 * sqlmigrateで実行されるSQL文を確認する
 * migrateで適用する

## APIからレコードの挿入や取得を行う

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py shell
Python 3.5.1 (default, Jul 22 2016, 10:16:05)
[GCC 4.9.2] on linux
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
# Accountクラスをインポート
>>> from open_multi_stack.models import Account
>>> dir(Account)
['DoesNotExist', 'MultipleObjectsReturned', 'STATUS_AVAILABLE', 'STATUS_SET', 'STATUS_UNAVAILABLE', '__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__setstate__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_base_manager', '_check_column_name_clashes', '_check_field_name_clashes', '_check_fields', '_check_id_field', '_check_index_together', '_check_local_fields', '_check_long_column_names', '_check_m2m_through_same_relationship', '_check_managers', '_check_model', '_check_ordering', '_check_swappable', '_check_unique_together', '_default_manager', '_deferred', '_do_insert', '_do_update', '_get_FIELD_display', '_get_next_or_previous_by_FIELD', '_get_next_or_previous_in_order', '_get_pk_val', '_get_unique_checks', '_meta', '_perform_date_checks', '_perform_unique_checks', '_save_parents', '_save_table', '_set_pk_val', 'check', 'clean', 'clean_fields', 'date_error_message', 'delete', 'from_db', 'full_clean', 'get_deferred_fields', 'get_status_display', 'objects', 'pk', 'prepare_database_save', 'refresh_from_db', 'save', 'save_base', 'serializable_value', 'unique_error_message', 'validate_unique']
# Accountテーブルのすべてのレコードを取得する
>>> Account.objects.all()
[]
# レコードの挿入
>>> q = Account(username="kosuke", tenantname="development tenant", tenant_id="1", password="secret", auth_url="http://kosukeshimofuji.jp", version="2", status="available", provider="unknown")
>>> q.save
# 挿入したレコードの閲覧
>>> Account.objects.all()
[<Account: Account object>]
```

## モデルにstrメソッドを追加する

上記の例ですべてのレコードを取得するとshellにオブジェクト名が表記されました。この表記では一体どのレコードが取れているのかわかりません。

```
>>> Account.objects.all()
[<Account: Account object>]
```

モデルに__str__メソッド加えることで、表記を自由に変更することができます。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/1b206a0333fcc9e9a4c9a38c7e8dfb3b79133b07)

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py shell
Python 3.5.1 (default, Jul 22 2016, 10:16:05)
[GCC 4.9.2] on linux
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
>>> from open_multi_stack.models import Account
>>> Account.objects.all()
[<Account: development tenant_unknown>]
```

tenant名でproviderの値が出力されるようになったので、どのレコードを参照しているのかわかりやすくなりました。

## 管理画面の追加と設定

 * 管理アカウントの作成

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py createsuperuser
Username (leave blank to use 'kosuke'):
Email address: kosuke.shimofuji@gmail.com
Password:
Password (again):
Superuser created successfully.
```

 * controllerを編集する

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/656e9fecc78321392dce65f3ed4acc3e5e0fbcef)

 * 管理画面にアクセスする

```
http://OpenMultiStack.test:8000/admin/
```

ログインするとGroupやUserテーブルなどのindex画面が並びます。

![django_admin_index]({{site.baseurl}}/images/2016/07/22/django_admin_index.png)

ユーザー一覧ページは以下のようになっています。

![django_user_index]({{site.baseurl}}/images/2016/07/22/django_user_index.png)


同じようにOpenStackのアカウントのデータを俯瞰し、データの編集も管理画面からできるようになれば、ウェブインターフェイスからAccount管理する機能については作成できそうです。

## Accountテーブルを管理画面から編集できるようにする

django_project/open_stack_multi/admin.pyを追加することによってadminアプリケーションにテーブルの存在を知らせることができます。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/2a515777c767b84a41556d562428eba3924c5e5a)

管理画面をリロードすると、テーブルを編集できるようになっています。

![update_admin_index]({{site.baseurl}}/images/2016/07/22/update_admin_index.png)

実際にレコードを追加してみます。

![add_account_on_admin]({{site.baseurl}}/images/2016/07/22/add_account_on_admin.png)

追加したレコードをpostgresqlから確認してみます。

```
django=> select * from open_multi_stack_account;
 id | username |     tenantname     | tenant_id | password |         auth_url          | version |  status   | provider
----+----------+--------------------+-----------+----------+---------------------------+---------+-----------+----------
  1 | kosuke   | development tenant | 1         | secret   | http://kosukeshimofuji.jp | 2       | available | unknown
  2 | hoge     | hoge               | hoge      | hoge     | hoge                      | hoge    | available | hoge
(2 行)
```

管理画面からレコードが追加できるようになったことが確認できました。しかしまだまだ不満があります。

## レコード追加時のフィールド順を決定する

初期状態では、フィールドの順序が定まっておらず、あまり美しくありません。そこで順序を指定します。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/400348a4a1f73d3ade79ca60f75bef2685123211)

## Accountテーブルの一覧をみやすくする

初期状態はでは以下のようになっており美しくありません。

![before_account_index]({{site.baseurl}}/images/2016/07/22/before_account_index.png)

そこで、きちんとフィールドを作ってみやすくするためにlistdisplayを使用します。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/241ee42e36b5758c5e91bbc999d0cb8e3d15de6a)

![after_account_index]({{site.baseurl}}/images/2016/07/22/after_account_index.png)

# RESTful API

クライアントはRESTful APIを用いてOpenMultiStackにインスタンス作成命令やインスタンス破棄命令を送ることができます。OpenMultiStackはこのような命令を受け取るとinstanceテーブルにレコード追加・削除の処理を行い、signalを発生させます。signalについては後で考えるとして、本項ではRESTful APIとinstanceテーブルの操作の仕組みを作成していきます。

## インスタンステーブル



# 参考文献

 * http://docs.djangoproject.jp/en/latest/index.html
 * http://www.django-rest-framework.org/
 * http://qiita.com/kimihiro_n/items/86e0a9e619720e57ecd8

