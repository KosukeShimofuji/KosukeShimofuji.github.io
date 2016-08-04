---
layout: post
title:  "OpenMultiStackというものを作りたい"
date:   2016-07-26 14:00:00 +0900
categories: python, development, django
toc: true
---

事情があってインスタンスを同時に100台程度稼働させたい。インスタンスの稼働時間は30-60分程度になる想定。じゃあOpenStackの出番だろうと思ってたら、著名なopenstack providerには最大20インスタンスしか同時に立ち上げられないような制限が入っていることに気づいた。openstackプロトコル自体は互換性があるんだから、openstack providerは複数にまたがって使えるよなあっていうことでOpenMultiStackというのを作ってみたいと思う。
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

## インスタンステーブル

インスタンステーブルはOpenStack上に構築されたインスタンスを管理するためのテーブルであり, インスタンス名, IPアドレス, 秘密鍵, Accountテーブルとの紐付け情報をカラムとして持つ。現在のインスタンステーブルの構成はたたき台であり、OpenStackとの連携の上でカラムは随時増やしていく。(そういうことが容易にできるのはdjangoの利点である)

 * instance tableの作成

```
class Instance(models.Model):
   name    = models.CharField(max_length=128)
    ip      = models.CharField(max_length=128)
    key     = models.CharField(max_length=128)
    account = models.ForeignKey(Account)

    def __str__(self):
        return self.name + '_' + self.ip + '_' + self.account
```

 * migrateの実行

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $  python manage.py makemigrations open_multi_stack
Migrations for 'open_multi_stack':
  0002_auto_20160725_1044.py:
    - Create model Instance
    - Alter field status on account
    - Add field account to instance
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py sqlmigrate open_multi_stack 0002
BEGIN;
--
-- Create model Instance
--
CREATE TABLE "open_multi_stack_instance" ("id" serial NOT NULL PRIMARY KEY, "name" varchar(128) NOT NULL, "ip" varchar(128) NOT NULL, "key" varchar(128) NOT NULL);
--
-- Alter field status on account
--
--
-- Add field account to instance
--
ALTER TABLE "open_multi_stack_instance" ADD COLUMN "account_id" integer NOT NULL;
ALTER TABLE "open_multi_stack_instance" ALTER COLUMN "account_id" DROP DEFAULT;
CREATE INDEX "open_multi_stack_instance_8a089c2a" ON "open_multi_stack_instance" ("account_id");
ALTER TABLE "open_multi_stack_instance" ADD CONSTRAINT "open_multi_s_account_id_1c0a0d19_fk_open_multi_stack_account_id" FOREIGN KEY ("account_id") REFERENCES "open_multi_stack_account" ("id") DEFERRABLE INITIALLY DEFERRED;

COMMIT;
```

作成されたinstanceテーブルの確認

```
django=> \d open_multi_stack_instance;
                                 テーブル "public.open_multi_stack_instance"
     列     |           型           |                                 修飾語
------------+------------------------+------------------------------------------------------------------------
 id         | integer                | not null default nextval('open_multi_stack_instance_id_seq'::regclass)
 name       | character varying(128) | not null
 ip         | character varying(128) | not null
 key        | character varying(128) | not null
 account_id | integer                | not null
インデックス:
    "open_multi_stack_instance_pkey" PRIMARY KEY, btree (id)
    "open_multi_stack_instance_8a089c2a" btree (account_id)
外部キー制約:
    "open_multi_s_account_id_1c0a0d19_fk_open_multi_stack_account_id" FOREIGN KEY (account_id) REFERENCES open_multi_stack_account(id) DEFERRABLE INITIALLY DEFERRED
```

インスタンステーブルも管理画面から閲覧・編集できれば便利です。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/653d8f282503b01c21284b1de59a392912ab0223)

リレーションを設定するとdjangoは自動的にaccountテーブルのレコードと紐付けなければならないことを検知し、account_idの入力をリストとして設定します。

![instance_table_on_admin]({{site.baseurl}}/images/2016/07/22/instance_table_on_admin.png)

# djangoのキューワーカー

OpenStackとの連携部分はHTTP通信とは切り離して非同期で行いたいので、キューワーカを使用したいと思います。
djangoのキューワーカーは[celery](http://docs.celeryproject.org/)がデファクトスタンダードのようです。
まずは[チュートリアル](http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html)に沿ってceleryを理解するところから始めます。

## ブローカーの選択

celeryはメッセージを送受信するためのメッセージブローカを必要とします。代表的な選択肢はRabbitMQ、Redis、Djangoがすでに利用しているデータベースなどがあります。ここでは最小限の構成にするためにすでに利用しているPostgresqlをブローカとして利用します。(大規模なキューワーカーのタスクを任せる場合はPostgresなどを利用するのは推奨されませんが、小さな仕組みであれば動作するようです。)

## djnago-celeryのインストール

```
$ pip install django-celery
Collecting django-celery
  Downloading django-celery-3.1.17.tar.gz (79kB)
    100% |████████████████████████████████| 81kB 1.9MB/s
Requirement already satisfied (use --upgrade to upgrade): celery>=3.1.15 in /home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages (from django-celery)
Requirement already satisfied (use --upgrade to upgrade): pytz>dev in /home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages (from celery>=3.1.15->django-celery)
Requirement already satisfied (use --upgrade to upgrade): kombu<3.1,>=3.0.34 in /home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages (from celery>=3.1.15->django-celery)
Requirement already satisfied (use --upgrade to upgrade): billiard<3.4,>=3.3.0.23 in /home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages (from celery>=3.1.15->django-celery)
Requirement already satisfied (use --upgrade to upgrade): amqp<2.0,>=1.4.9 in /home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages (from kombu<3.1,>=3.0.34->celery>=3.1.15->django-celery)
Requirement already satisfied (use --upgrade to upgrade): anyjson>=0.3.3 in /home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages (from kombu<3.1,>=3.0.34->celery>=3.1.15->django-celery)
Installing collected packages: django-celery
  Running setup.py install for django-celery ... done
Successfully installed django-celery-3.1.17
```

## SQLalchemyのインストール

backendにpostgresqlを利用するにはSQLalchemyをcelelyが利用するのでインストールする。

```
pip install sqlalchemy
```

## djceleryの設定

djangoで使用しているデータベースを利用すると決定したので[ここ](http://docs.celeryproject.org/en/latest/getting-started/brokers/django.html#broker-django)を参考に設定を行います。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/a9dccfb5acc9de5359523e6fd3d1105b4e163bba)
[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/cd76de70707beb915e5f4b48e56f175033ffcb0c)

 * celery用のテーブルを作成

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py makemigrations djcelery
Migrations for 'djcelery':
  0002_auto_20160725_1435.py:
    - Alter field status on taskmeta
    - Alter field state on taskstate

(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py sqlmigrate djcelery 0001
BEGIN;
--
-- Create model CrontabSchedule
--
CREATE TABLE "djcelery_crontabschedule" ("id" serial NOT NULL PRIMARY KEY, "minute" varchar(64) NOT NULL, "hour" varchar(64) NOT NULL, "day_of_week" varchar(64) NOT NULL, "day_of_month" varchar(64) NOT NULL, "month_of_year" varchar(64) NOT NULL);
--
-- Create model IntervalSchedule
--
CREATE TABLE "djcelery_intervalschedule" ("id" serial NOT NULL PRIMARY KEY, "every" integer NOT NULL, "period" varchar(24) NOT NULL);
--
-- Create model PeriodicTask
--
CREATE TABLE "djcelery_periodictask" ("id" serial NOT NULL PRIMARY KEY, "name" varchar(200) NOT NULL UNIQUE, "task" varchar(200) NOT NULL, "args" text NOT NULL, "kwargs" text NOT NULL, "queue" varchar(200) NULL, "exchange" varchar(200) NULL, "routing_key" varchar(200) NULL, "expires" timestamp with time zone NULL, "enabled" boolean NOT NULL, "last_run_at" timestamp with time zone NULL, "total_run_count" integer NOT NULL CHECK ("total_run_count" >= 0), "date_changed" timestamp with time zone NOT NULL, "description" text NOT NULL, "crontab_id" integer NULL, "interval_id" integer NULL);
--
-- Create model PeriodicTasks
--
CREATE TABLE "djcelery_periodictasks" ("ident" smallint NOT NULL PRIMARY KEY, "last_update" timestamp with time zone NOT NULL);
--
-- Create model TaskMeta
--
CREATE TABLE "celery_taskmeta" ("id" serial NOT NULL PRIMARY KEY, "task_id" varchar(255) NOT NULL UNIQUE, "status" varchar(50) NOT NULL, "result" text NULL, "date_done" timestamp with time zone NOT NULL, "traceback" text NULL, "hidden" boolean NOT NULL, "meta" text NULL);
--
-- Create model TaskSetMeta
--
CREATE TABLE "celery_tasksetmeta" ("id" serial NOT NULL PRIMARY KEY, "taskset_id" varchar(255) NOT NULL UNIQUE, "result" text NOT NULL, "date_done" timestamp with time zone NOT NULL, "hidden" boolean NOT NULL);
--
-- Create model TaskState
--
CREATE TABLE "djcelery_taskstate" ("id" serial NOT NULL PRIMARY KEY, "state" varchar(64) NOT NULL, "task_id" varchar(36) NOT NULL UNIQUE, "name" varchar(200) NULL, "tstamp" timestamp with time zone NOT NULL, "args" text NULL, "kwargs" text NULL, "eta" timestamp with time zone NULL, "expires" timestamp with time zone NULL, "result" text NULL, "traceback" text NULL, "runtime" double precision NULL, "retries" integer NOT NULL, "hidden" boolean NOT NULL);
--
-- Create model WorkerState
--
CREATE TABLE "djcelery_workerstate" ("id" serial NOT NULL PRIMARY KEY, "hostname" varchar(255) NOT NULL UNIQUE, "last_heartbeat" timestamp with time zone NULL);
--
-- Add field worker to taskstate
--
ALTER TABLE "djcelery_taskstate" ADD COLUMN "worker_id" integer NULL;
ALTER TABLE "djcelery_taskstate" ALTER COLUMN "worker_id" DROP DEFAULT;
ALTER TABLE "djcelery_periodictask" ADD CONSTRAINT "djcelery_per_crontab_id_75609bab_fk_djcelery_crontabschedule_id" FOREIGN KEY ("crontab_id") REFERENCES "djcelery_crontabschedule" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "djcelery_periodictask" ADD CONSTRAINT "djcelery_p_interval_id_b426ab02_fk_djcelery_intervalschedule_id" FOREIGN KEY ("interval_id") REFERENCES "djcelery_intervalschedule" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "djcelery_periodictask_f3f0d72a" ON "djcelery_periodictask" ("crontab_id");
CREATE INDEX "djcelery_periodictask_1dcd7040" ON "djcelery_periodictask" ("interval_id");
CREATE INDEX "djcelery_periodictask_name_cb62cda9_like" ON "djcelery_periodictask" ("name" varchar_pattern_ops);
CREATE INDEX "celery_taskmeta_662f707d" ON "celery_taskmeta" ("hidden");
CREATE INDEX "celery_taskmeta_task_id_9558b198_like" ON "celery_taskmeta" ("task_id" varchar_pattern_ops);
CREATE INDEX "celery_tasksetmeta_662f707d" ON "celery_tasksetmeta" ("hidden");
CREATE INDEX "celery_tasksetmeta_taskset_id_a5a1d4ae_like" ON "celery_tasksetmeta" ("taskset_id" varchar_pattern_ops);
CREATE INDEX "djcelery_taskstate_9ed39e2e" ON "djcelery_taskstate" ("state");
CREATE INDEX "djcelery_taskstate_b068931c" ON "djcelery_taskstate" ("name");
CREATE INDEX "djcelery_taskstate_863bb2ee" ON "djcelery_taskstate" ("tstamp");
CREATE INDEX "djcelery_taskstate_662f707d" ON "djcelery_taskstate" ("hidden");
CREATE INDEX "djcelery_taskstate_state_53543be4_like" ON "djcelery_taskstate" ("state" varchar_pattern_ops);
CREATE INDEX "djcelery_taskstate_task_id_9d2efdb5_like" ON "djcelery_taskstate" ("task_id" varchar_pattern_ops);
CREATE INDEX "djcelery_taskstate_name_8af9eded_like" ON "djcelery_taskstate" ("name" varchar_pattern_ops);
CREATE INDEX "djcelery_workerstate_f129901a" ON "djcelery_workerstate" ("last_heartbeat");
CREATE INDEX "djcelery_workerstate_hostname_b31c7fab_like" ON "djcelery_workerstate" ("hostname" varchar_pattern_ops);
CREATE INDEX "djcelery_taskstate_ce77e6ef" ON "djcelery_taskstate" ("worker_id");
ALTER TABLE "djcelery_taskstate" ADD CONSTRAINT "djcelery_taskstat_worker_id_f7f57a05_fk_djcelery_workerstate_id" FOREIGN KEY ("worker_id") REFERENCES "djcelery_workerstate" ("id") DEFERRABLE INITIALLY DEFERRED;

COMMIT;
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py migrate djcelery
Operations to perform:
  Apply all migrations: djcelery
Running migrations:
  Rendering model states... DONE
  Applying djcelery.0001_initial... OK
  Applying djcelery.0002_auto_20160725_1435... OK
```

## Taskの作成

10秒待って足し算の結果を返すタスクを作成します。

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/1474bdde296fe5a7594cc47fd539cb7d2eeac3fb)

## Workerの起動

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ celery -A django_project worker -l info -c 1
/home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages/celery/apps/worker.py:161: CDeprecationWarning:
Starting from version 3.2 Celery will refuse to accept pickle by default.

The pickle serializer is a security concern as it may give attackers
the ability to execute any command.  It's important to secure
your broker from unauthorized access when using pickle, so we think
that enabling pickle should require a deliberate action and not be
the default choice.

If you depend on pickle then you should set a setting to disable this
warning and to be sure that everything will continue working
when you upgrade to Celery 3.2::

    CELERY_ACCEPT_CONTENT = ['pickle', 'json', 'msgpack', 'yaml']

You must only enable the serializers that you will actually use.


  warnings.warn(CDeprecationWarning(W_PICKLE_DEPRECATED))

[2016-07-25 14:40:30,515: WARNING/MainProcess] /home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages/celery/apps/worker.py:161: CDeprecationWarning:
Starting from version 3.2 Celery will refuse to accept pickle by default.

The pickle serializer is a security concern as it may give attackers
the ability to execute any command.  It's important to secure
your broker from unauthorized access when using pickle, so we think
that enabling pickle should require a deliberate action and not be
the default choice.

If you depend on pickle then you should set a setting to disable this
warning and to be sure that everything will continue working
when you upgrade to Celery 3.2::

    CELERY_ACCEPT_CONTENT = ['pickle', 'json', 'msgpack', 'yaml']

You must only enable the serializers that you will actually use.


  warnings.warn(CDeprecationWarning(W_PICKLE_DEPRECATED))


 -------------- celery@OpenMultiStack.test v3.1.23 (Cipater)
---- **** -----
--- * ***  * -- Linux-3.16.0-4-amd64-x86_64-with-debian-8.5
-- * - **** ---
- ** ---------- [config]
- ** ---------- .> app:         django_project:0x7f3024c904e0
- ** ---------- .> transport:   django://localhost//
- ** ---------- .> results:     disabled://
- *** --- * --- .> concurrency: 1 (prefork)
-- ******* ----
--- ***** ----- [queues]
 -------------- .> celery           exchange=celery(direct) key=celery


[tasks]
  . django_project.celery.debug_task
  . open_multi_stack.tasks.add

[2016-07-25 14:40:30,544: INFO/MainProcess] Connected to django://localhost//
/home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages/celery/fixups/django.py:265: UserWarning: Using settings.DEBUG leads to a memory leak, never use this setting in production environments!
  warnings.warn('Using settings.DEBUG leads to a memory leak, never '

[2016-07-25 14:40:30,571: WARNING/MainProcess] /home/kosuke/.pyenv/versions/3.5.1/envs/OpenMultiStack/lib/python3.5/site-packages/celery/fixups/django.py:265: UserWarning: Using settings.DEBUG leads to a memory leak, never use this setting in production environments!
  warnings.warn('Using settings.DEBUG leads to a memory leak, never '

[2016-07-25 14:40:30,573: WARNING/MainProcess] celery@OpenMultiStack.test ready.
```

## Taskのテスト

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py shell
Python 3.5.1 (default, Jul 22 2016, 10:16:05)
[GCC 4.9.2] on linux
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
>>> from open_multi_stack.tasks import add
>>> result = add.delay(1, 2)
>>> result = add.delay(1, 2)
>>> result.ready()
False
>>> result.ready()
False
>>> result.ready()
False
```

ここで10秒待ってれば、result.ready()がTrueを返すはずなのだが、いつまでたっても値を返さない。workerの方でエラーが出ていた。

```
sqlalchemy.exc.ProgrammingError: (psycopg2.ProgrammingError) relation "task_id_sequence" does not exist
LINE 1: ...us, result, date_done, traceback) VALUES (nextval('task_id_s...
                                                             ^
 [SQL: "INSERT INTO celery_taskmeta (id, task_id, status, result, date_done, traceback) VALUES (nextval('task_id_sequence'), %(task_id)s, %(status)s, %(result)s, %(date_done)s, %(traceback)s) RETURNING celery_taskmeta.id"] [parameters: {'traceback': None, 'result': None, 'date_done': datetime.datetime(2016, 7, 25, 5, 56, 32, 951020), 'task_id': '74249288-dc45-40ca-944a-cd0c4a161961', 'status': 'PENDING'}]
```

ちょうどこの問題について[議論](https://github.com/celery/celery/issues/3213)されており、backendをPostgresqlを使用した時に起きている問題とのこと。2016/05/18に報告されているので新しい問題のようだ。とりあえず回避策としてbackendのデータベースをsqliteにしておいて、修正されたpostgresqlに統一しようと思う。(ここで修正パッチ投げれるようになったらかっこいいな)

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/2894ba8879805bdbd04004d6bcbd7ad051c38491)

migrateし直して、実行すると成功した。

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py shell
Python 3.5.1 (default, Jul 22 2016, 10:16:05)
[GCC 4.9.2] on linux
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
>>> from open_multi_stack.tasks import add
>>> result = add.delay(1, 2)
>>> result.ready()
False
>>> result.ready()
False
>>> result.ready()
(10秒経過)
True
>>> result.get()
3
```

# RESTful API

クライアントはRESTful APIを用いてOpenMultiStackにインスタンス作成命令やインスタンス破棄命令を送ることができます。APIから直接インスタンステーブルを操作することはせず、Queueテーブルを作成してクライアントからの操作に対応します。

 * インスタンス作成のFlow
   * クライアントからPOSTメソッドでインスタンス作成命令をOpenMultiStackに送信する
   * Queueテーブルのレコードを作成する
   * celeryの非同期処理を使い、OpenStackのインスタンス作成処理を開始する
   * インスタンス作成命令の返り値としてQueueレコードの主キーを返す
   * 非同期のインスタンス作成処理はOpenStackから得られた値をInstanceテーブルに挿入する
  
 * インスタンスが作成されたかどうかを確認
   * クライアントからGETメソッドでQueueレコードの内容を確認し、インスタンスが立ち上がったかを確認する

 * インスタンス破棄のFlow
   * クライアントからDeleteメソッドでインスタンス破棄命令をOpenMultiStackに送信する
   * celeryの非同期処理を使い、OpenStackのインスタンス破棄処理を開始する
   * インスタンス破棄命令の返り値としてQueueレコードの主キーを返す
   * 非同期のインスタンス破棄処理はOpenStackからインスタンスが削除されたことを確認して、Instanceテーブルの該当レコードを削除する

 * インスタンスが破棄されたかどうかを確認
   * クライアントからGETメソッドでQueueテーブルのレコードの内容を確認し、インスタンスが破棄されたかを確認する

## Queueテーブルを定義

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/069eaca9ced7cecd94fa878ab0f497f23067b911)

## django rest frameworkのインストール

```
$ pip install djangorestframework django-filter 
```

## django rest frameworkの有効化

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/db917fe29c8bff3d076d3e7f68f4c14e72b20729)

## シリアライザーを定義する

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/7ce034c7729d978bb172147b67747148b1982bce)

## ViewSetを定義する

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/d5ff35cce4855d05dbd43afef553e41012bdaf4e)

## ControllerにapiのURIを追加する

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/7150b4254b7bbefcc0d11ffba000ea53a42a6ac7)

## APIをテストする

http://openmultistack.test:8000/api/にアクセスすると以下のような描画がなされます。

![django_rest_framework_testscreen.png]({{site.baseurl}}/images/2016/07/22/django_rest_framework_testscreen.png)

 * Queueの追加

```
$ curl -X POST http://openmultistack.test:8000/api/queues/
{"id":50,"status":"queueing","regist_datetime":"2016-07-26T01:29:26.990608Z","instance":null}
```

 * Queue全体のの閲覧

```
$ curl -X GET http://openmultistack.test:8000/api/queues/
[{"id":50,"status":"queueing","regist_datetime":"2016-07-26T01:29:26.990608Z","instance":null},{"id":51,"status":"queueing","regist_datetime":"2016-07-26T01:30:34.131312Z","instance":null},{"id":52,"status":"queueing","regist_datetime":"2016-07-26T01:30:36.313087Z","instance":null}]
```

 * Queueの個別閲覧

```
$ curl -X GET http://openmultistack.test:8000/api/queues/51/
{"id":51,"status":"queueing","regist_datetime":"2016-07-26T01:30:34.131312Z","instance":null}
```

 * Queueの削除

```
$ curl -X DELETE http://openmultistack.test:8000/api/queues/51/
$ curl -X GET http://openmultistack.test:8000/api/queues/51/
{"detail":"Not found."}
```

# Signal

Queueを作れるようになりましたので、Queueが登録されてからopenstack clientを呼び出すトリガーを用意する必要があります。
ここではSignalを使って実装してみたいと思います。
[Signal](http://docs.djangoproject.jp/en/latest/topics/signals.html)にはモデルのsave及びdeleteの前後にイベントを発生させる機能があります。これを使えば実装できそうです。
まずはSignalの動きを把握するためにQueueにレコードを書き込んだ時に/tmp/test.txtに文字列を書き込む仕組みを作成してみます。

[commi](https://github.com/KosukeShimofuji/OpenMultiStack/commit/4ab738537a610284494a986e6f631540a8388e6b)

上記commitを反映させてQueueに書き込みを行うとファイルに文字列書き込みを行うことができます。

```
$ curl -X POST http://openmultistack.test:8000/api/queues/
{"id":53,"status":"queueing","regist_datetime":"2016-07-26T02:46:54.387192Z","instance":null}
$ cat /tmp/test.txt
test 2016/07/26 11:46:54
```

Queueテーブルに書き込まれた情報を取得するにはどうすればいいのでしょうか？reciverが受け取っているinstansオブジェクトを参照することで値を得ることができます。

```
str(instance.id)
```

QueueレコードのIDが取得できればQueueテーブルとOpenStack Clientとの連携はできそうです。

# 参考文献

 * http://docs.djangoproject.jp/en/latest/index.html
 * http://www.django-rest-framework.org/
 * http://qiita.com/kimihiro_n/items/86e0a9e619720e57ecd8
 * http://daigo3.github.io/fullstackpython.github.com/task-queues.html
 * http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html
 * http://docs.celeryproject.org/en/latest/django/first-steps-with-django.html
 * http://qiita.com/shun666/items/53df90f6d73de2862f1d
 * http://www.django-rest-framework.org/tutorial/quickstart/
 * http://racchai.hatenablog.com/entry/2016/04/12/Django_REST_framework_%E8%B6%85%E5%85%A5%E9%96%80#API-経由でArticleを作成してみよう
 * http://www.koopman.me/2015/01/django-signals-example/


