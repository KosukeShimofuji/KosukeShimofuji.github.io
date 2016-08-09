---
layout: post
title:  "OpenMultiStackというものを作りたいの続き"
date:   2016-08-09 10:45:00 +0900
categories: development
toc: true
---

[OpenMultiStackというものを作りたい]({{site.baseurl}}/2016/07/26/OpenMultiStack/)の続きになります。前回の記事はdjangoを調査して、OpenStackクライアントとの連携について考えてきました。今回は実際にdjangoにOpenStackクライアントの機能を埋め込んで、RESTful APIからOpenStackを操作するところを目標に作業を進めていきます。

# OpenMultiStackにアカウント情報を登録

前回、管理画面からアカウント情報を入力するための仕組みは作成済みです。ここにOpenStackのアカウント情報を格納して、クライアント側で取り出して使います。

![regist_account_on_OpenMultiStack.png]({{site.baseurl}}/images/2016/08/02/regist_account_on_OpenMultiStack.png)


# Signalから実行されるプロセスについて調査する

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/f30350db1f250a3237c01e375cfbd251bcc48bc4)のような10秒sleepするテストコードを作成して、Signalから実行されるプロセスについて調査する。
調査の結果、呼び出されたコードのところでhttp responseも10秒待っていることがわかった。

# Signalからキューワーカーを起動する

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/8af6e01156c30265bd1cc1b0fe88f5cedcc9c121)

上記検証コードで、HTTPレスポンスと切り離して処理をバックエンドで行えることを確認した。

# Queueテーブルのレコードをキューワーカーから取得する

[commit](https://github.com/KosukeShimofuji/OpenMultiStack/commit/cca405a9caac3d20c05f06091ebdfa5d7612b6b6)でキューワーカーがdjangoからqueue_idを取得できるのは確認した。
queue_idからQueueテーブルのレコード情報を取得する。 django shellからmodelの扱いを学ぶ。

```
(OpenMultiStack) kosuke@OpenMultiStack ~/OpenMultiStack/django_project $ python manage.py shell
>>> from open_multi_stack.models import Queue
>>> dir(Queue)
['DoesNotExist', 'MultipleObjectsReturned', 'STATUS_BOOTING', 'STATUS_DESTROYING', 'STATUS_FAILED', 'STATUS_QUEUEING', 'STATUS_RUNNING', 'STATUS_SET', '__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__setstate__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_base_manager', '_check_column_name_clashes', '_check_field_name_clashes', '_check_fields', '_check_id_field', '_check_index_together', '_check_local_fields', '_check_long_column_names', '_check_m2m_through_same_relationship', '_check_managers', '_check_model', '_check_ordering', '_check_swappable', '_check_unique_together', '_default_manager', '_deferred', '_do_insert', '_do_update', '_get_FIELD_display', '_get_next_or_previous_by_FIELD', '_get_next_or_previous_in_order', '_get_pk_val', '_get_unique_checks', '_meta', '_perform_date_checks', '_perform_unique_checks', '_save_parents', '_save_table', '_set_pk_val', 'check', 'clean', 'clean_fields', 'date_error_message', 'delete', 'from_db', 'full_clean', 'get_deferred_fields', 'get_next_by_regist_datetime', 'get_previous_by_regist_datetime', 'get_status_display', 'instance', 'objects', 'pk', 'prepare_database_save', 'refresh_from_db', 'save', 'save_base', 'serializable_value', 'unique_error_message', 'validate_unique']
>>> dir(Queue.objects)
['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_constructor_args', '_copy_to_model', '_db', '_get_queryset_methods', '_hints', '_inherited', '_insert', '_queryset_class', '_set_creation_counter', '_update', 'aggregate', 'all', 'annotate', 'bulk_create', 'check', 'complex_filter', 'contribute_to_class', 'count', 'create', 'creation_counter', 'dates', 'datetimes', 'db', 'db_manager', 'deconstruct', 'defer', 'distinct', 'earliest', 'exclude', 'exists', 'extra', 'filter', 'first', 'from_queryset', 'get', 'get_or_create', 'get_queryset', 'in_bulk', 'iterator', 'last', 'latest', 'model', 'name', 'none', 'only', 'order_by', 'prefetch_related', 'raw', 'reverse', 'select_for_update', 'select_related', 'update', 'update_or_create', 'use_in_migrations', 'using', 'values', 'values_list']
>>> Queue.objects.all
<bound method BaseManager.all of <django.db.models.manager.Manager object at 0x7f98ef5a8be0>>
>>> Queue.objects.get(id=130)
<Queue: 2016-08-02 06:58_queueing>
>>> Queue.objects.get(id=130).status
'queueing'
>>> Queue.objects.get(id=130).regist_datetime
datetime.datetime(2016, 8, 2, 6, 58, 24, 523425, tzinfo=<UTC>)
>>> Queue.objects.get(id=130).id
130
>>> dir(Queue.objects.get(id=130))
['DoesNotExist', 'MultipleObjectsReturned', 'STATUS_BOOTING', 'STATUS_DESTROYING', 'STATUS_FAILED', 'STATUS_QUEUEING', 'STATUS_RUNNING', 'STATUS_SET', '__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__setstate__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_base_manager', '_check_column_name_clashes', '_check_field_name_clashes', '_check_fields', '_check_id_field', '_check_index_together', '_check_local_fields', '_check_long_column_names', '_check_m2m_through_same_relationship', '_check_managers', '_check_model', '_check_ordering', '_check_swappable', '_check_unique_together', '_default_manager', '_deferred', '_do_insert', '_do_update', '_get_FIELD_display', '_get_next_or_previous_by_FIELD', '_get_next_or_previous_in_order', '_get_pk_val', '_get_unique_checks', '_meta', '_perform_date_checks', '_perform_unique_checks', '_save_parents', '_save_table', '_set_pk_val', '_state', 'check', 'clean', 'clean_fields', 'date_error_message', 'delete', 'from_db', 'full_clean', 'get_deferred_fields', 'get_next_by_regist_datetime', 'get_previous_by_regist_datetime', 'get_status_display', 'id', 'instance', 'instance_id', 'objects', 'pk', 'prepare_database_save', 'refresh_from_db', 'regist_datetime', 'save', 'save_base', 'serializable_value', 'status', 'unique_error_message', 'validate_unique']
```

# インスタンス作成フローを整理する

 * クライアントは以下のリクエストを発行することにより、OpenMultiStackにインスタンス作成Queueを作成する

   ```
$ curl -X POST http://openmultistack.test:8000/api/queues/
{"id":50,"status":"queueing","regist_datetime":"2016-07-26T01:29:26.990608Z","instance":null}
   ```

 * OpenMultiStackはdjangoのSignal機能により、Qeueuテーブルのレコード書き込み時にフックを挟み込みDjeangoキューワーカーのタスクを起動する
   * キューワーカーにOpenStackクライアンの機能を移譲することにより、HTTP通信と切り離すことができる
   * 初期status = request
   * タスク処理開始時 = accept
 * Djangoキューワーカーのインスタンス作成処理はQueueレコードとInstanceレコードを操作しながら、インスタンスを作成する

# 動くようになった

[OpenMultiStack](https://github.com/KosukeShimofuji/OpenMultiStack)

一般化するなら、flavorやosの剪定までできるように成るといいけど、とりあえず自分がやりたいことができるレベルの実装にはなったので、一旦ここで開発を止める。

# 参考文献

 * https://torina.top/
 * https://www.ibm.com/developerworks/jp/cloud/library/cl-openstack-pythonapis/

