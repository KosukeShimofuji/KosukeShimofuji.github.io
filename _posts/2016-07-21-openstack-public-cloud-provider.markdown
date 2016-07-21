---
layout: post
title:  "OpenStack public cloud providerの調査"
date:   2016-07-21 16:00:00 +0900
categories: OpenStack
toc: true
---

やんごとなき事情により複数のOpenStack public cloud providerについて調べました。

# 料金に着目した調査

## [Auro](https://www.auro.io/)

AuroはカナダのOpenStack public cloud providerです。提供しているOpenStackのRegionはTrontoとVancouverの2箇所の模様です。

![auro_standard_price]({{site.baseurl}}/images/2016/07/20/auro_standard.png)
![auro_highperformance_price]({{site.baseurl}}/images/2016/07/20/auro_highperformance.png)

登録にはマニュアルでの認証が入るということで4時間待ってくれと言われますが、私は1日以上待っても認証されませんでした。

## [catalyst](http://catalyst.net.nz/)

catalystはOpenStack public cloud providerです。提供しているOpenStackのRegionはどちらもニュージーランドのPoriruaとWellingtonです。

![catalyst_price]({{site.baseurl}}/images/2016/07/20/catalyst_price.png)

## [citycloud](https://www.citycloud.com)

citycloudは[citynetwork](https://www.citynetworkhosting.com/company-details/)というスウェーデンの企業が提供するOpenStack public cloud providerです。提供しているOpenStackのRegionはLondon、Stockholm、Karlskronaです。compute nodeの値段は[こちら](https://www.citycloud.com/pricing/)から閲覧することができます。

![citycloud_price]({{site.baseurl}}/images/2016/07/20/citycloud_price.png)

## [conoha](https://www.conoha.jp)

CONOHAは[GMO INTERNET](https://www.gmo.jp/)が提供するOpenStack public cloud providerです。OpenStackといえばCONOHAだと連想する日本人はとても多いと思います。提供しているOpenStackのRegionはTokyo、Singapore、San Joseです。

![conoha_price]({{site.baseurl}}/images/2016/07/20/conoha_price.png)

## [DataCentred](http://www.datacentred.co.uk/)

イギリスのOpenStack public cloud providerです。提供しているOpenStackのRegionはManchesterのみです。

![datacentred_price]({{site.baseurl}}/images/2016/07/20/datacentred_price.png)

## [dreamhost](https://www.dreamhost.com/)

アメリカのOpenStack public cloud providerです。提供しているOpenStackのRegionはOneという名前になっていてよくわかりませんが、一つしか無いようです。

![dreamhost_price]({{site.baseurl}}/images/2016/07/20/dreamhost_price.png)

## [elastx](http://elastx.se/en)

スウェーデンのOpenStack public cloud providerです。こちらも提供しているOpenStackのRegionはOneという名前になっていてよくわかりませんが、一つしか無いようです。

![elastx_price]({{site.baseurl}}/images/2016/07/20/elastx_price.png)

## [entercloudsuite](http://www.entercloudsuite.com/en/)

イタリアのOpenStack public cloud providerです。提供しているOpenStackのRegionはAmsterdam、Milan、Frankfurtです。

![entercloudsuite_price]({{site.baseurl}}/images/2016/07/20/entercloudsuite_price.png)

## [ibmcloud](http://www.softlayer.com/jp/virtual-servers)

IBMのOpenStack public cloud providerです。提供しているOpenStackのRegionはロンドンのみです。

![ibmcloud_price]({{site.baseurl}}/images/2016/07/20/ibmcloud_price.png)

## [internap](https://iweb.com/cloud-servers)

カナダのOpenStack public cloud providerです。提供しているOpenStackのRegionはAmsterdam、Dallas、New Yorkです。

![internap_price]({{site.baseurl}}/images/2016/07/20/internap_price.png)

## [OVH](https://www.ovh.com)

フランスのOpenStack public cloud providerです。提供しているOpenStackのRegionはBeauharnois、Strassbourg、Gravelinesです。

![ovh_price]({{site.baseurl}}/images/2016/07/20/ovh_price.png)

VPSの構築にはID Card、免許証、パスポート、公共料金の支払い証明書、銀行の明細書、公式な文書のうち2つの提出が求められます。

## [rackspace](https://www.rackspace.com/)

rackspaceはNASA Amesと共にOpenStackプロジェクトを初めた企業であり、もちろんOpenStack public cloud providerとしても活動している。OpenStackのRegionはDallas、Hong Kong、Washington, D.C.、    London、Chicago、Sydneyです。

![rackspace_price]({{site.baseurl}}/images/2016/07/20/rackspace_price.png)

## [switch](http://www.switch.ch/)

switchはスウェーデンのOpenStack public cloud providerです。提供しているOpenStackのRegionはLausanne、Zurichです。

![switch_price]({{site.baseurl}}/images/2016/07/20/switch_price.png)

## [ultimum](http://ultimum.io/solutions/ultimum-cloud/)

ultimumはチェコのOpenStack public cloud providerです。提供しているOpenStackのRegionはOneというニックネームになっており所在地はわかりませんが一箇所で提供しているようです。

![ultimum_price]({{site.baseurl}}/images/2016/07/20/ultimum_price.png)

## [UnitedStack](https://www.ustack.com/)

UnitedStackは中国のOpenStack public cloud providerです。Regionは北京、広東となっています。料金は[こちら](https://www.ustack.com/uos/price/)から構成を選ぶことで表示されます。

![unitedstack_price]({{site.baseurl}}/images/2016/07/20/unitedstack_price.png)

## [vexxhost](https://vexxhost.com/)

vexxhostはカナダのOpenStack public cloud providerです。Regionはモンテリオールになっています。

![vexxhost_price]({{site.baseurl}}/images/2016/07/20/vexxhost_price.png)

vexxhostは比較的簡単に登録して使うことができます。SMS認証や免許証、パスポートなどは求められませんでした。PayPalを登録することでCloud Consoleを使うことができます。

## [zetta](https://zetta.io/en/about/contact/)

zettaはノルウェーのOpenStack public cloud providerです。RegionはOsloになっており、一箇所で提供しているようです。

![zetta_price]({{site.baseurl}}/images/2016/07/20/zetta_price.png)

## 料金に着目した調査についてまとめ

同じようなフレーバーの提供でも、企業によっては倍以上値段に差があることがわかった。Conohaは料金的にも非常に優れているので、普通にOpenStackを使うならConohaを選んでおいて間違いは無いだろうと思う。ovhの料金もかなり低めだが、OpenStackを利用するのに身分証明書を提出するのは手間だったので利用を躊躇した。今回はConoha以外のOpenStackの挙動を見るのが目的の一つなので、手軽に利用開始することができ、値段もConohaとあまり変わらないできたvexxhostを利用する。

# APIに着目した調査

## openstack clientとdirenvをインストール

各ベンダーのopenstack clientの対応状況を知りたいのでopenstack clientを利用できる環境を構築します。

 * python 3.5.1のインストール

```
$ pyenv install 3.5.1
$ pyenv virtualenv 3.5.1 OpenMultiStack
$ pyenv global OpenMultiStack
$ pip install --upgrade pip
```

 * openstackclientのインストール

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

## vexxhost

 * envrcの用意

```
$ mkdir vexxhost
$ cd vexxhost
$ cat > .envrc
export OS_TENANT_NAME="SECRET"
export OS_USERNAME="SECRET"
export OS_PASSWORD="SECRET"
export OS_AUTH_URL="https://auth.vexxhost.net/v2.0/"
export OS_REGION_NAME="ca-ymq-1"
CTRL+C
$ direnv allow
```

 * flavorの確認

```
kosuke@OpenMultiStack ~/vexxhost $ nova flavor-list
+--------------------------------------+-----------------+-----------+------+-----------+------+-------+-------------+-----------+
| ID                                   | Name            | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public |
+--------------------------------------+-----------------+-----------+------+-----------+------+-------+-------------+-----------+
| 0c1d9008-f546-4608-9e8f-f8bdaec8dddd | v1-standard-64  | 65536     | 1600 | 0         |      | 24    | 1.0         | True      |
| 0da688af-bb0c-4116-a158-cbf37240a8b1 | v1-standard-32  | 32768     | 800  | 0         |      | 16    | 1.0         | True      |
| 2f8730dd-7688-4b72-a512-99fb9a482414 | v1-standard-16  | 16384     | 400  | 0         |      | 8     | 1.0         | True      |
| 5741c775-92a4-4488-bd77-dd7b08e2be81 | v1-standard-96  | 98304     | 2000 | 0         |      | 24    | 1.0         | True      |
| 5cf64088-893b-46b5-9bb1-ee020277635d | v1-standard-4   | 4096      | 100  | 0         |      | 4     | 1.0         | True      |
| 69471d69-61fb-40dd-bdf3-e6b7f4e6daa3 | v1-standard-48  | 49152     | 1200 | 0         |      | 16    | 1.0         | True      |
| 6eec77b4-2286-4e3b-b3f0-cac67aa2c727 | v1-standard-8   | 8192      | 200  | 0         |      | 8     | 1.0         | True      |
| bbcb7eb5-5c8d-498f-9d7e-307c575d3566 | v1-standard-1   | 1024      | 40   | 0         |      | 2     | 1.0         | True      |
| ca2a6e9c-2236-4107-8905-7ae9427132ff | v1-standard-2   | 2048      | 50   | 0         |      | 4     | 1.0         | True      |
| e82d0a5b-8031-4526-9a5d-a15f7b4d48ff | v1-standard-128 | 131072    | 2500 | 0         |      | 24    | 1.0         | True      |
+--------------------------------------+-----------------+-----------+------+-----------+------+-------+-------------+-----------+
```

 * imageの確認

```
kosuke@OpenMultiStack ~/vexxhost $ nova image-list
WARNING: Command image-list is deprecated and will be removed after Nova 15.0.0 is released. Use python-glanceclient or openstackclient instead.
+--------------------------------------+-------------------------------------+--------+--------+
| ID                                   | Name                                | Status | Server |
+--------------------------------------+-------------------------------------+--------+--------+
| a2c28e26-e52a-4d26-985c-6ae5cec63935 | CentOS 6.5 (2014-08-29)             | ACTIVE |        |
| 2a7f76d5-185a-4de9-a9aa-51efafee4ac7 | CentOS 6.8 (2016-06-08)             | ACTIVE |        |
| 9aa8b7dc-bc85-4a67-8677-833a787d9ee1 | CentOS 7-1406 (2014-08-29)          | ACTIVE |        |
| 75c61552-4ade-4993-8814-4bab5de73c54 | CentOS 7-1503 (2015-12-22)          | ACTIVE |        |
| 9a78b7ac-1ea9-47d4-a813-f5961e4f147c | CentOS 7-1509 (2015-11-03)          | ACTIVE |        |
| 35853d1e-d337-42ba-bec3-133fa73cc9ea | CentOS 7-1603 (2016-04-05)          | ACTIVE |        |
| 1702b967-6e18-4e23-8bb9-60d6727a520d | CentOS 7.1605 (2016-06-08)          | ACTIVE |        |
| 9da93d6c-21fb-4bcc-8b26-bc9cbcb43628 | CoreOS Alpha 1097.0.0               | ACTIVE |        |
| 822e98ba-9f2d-45a3-b8c3-763f7e6e16bf | CoreOS Beta 1068.3.0                | ACTIVE |        |
| 26d09d0e-b53e-4ebb-8815-b3b469283bc1 | CoreOS Stable 1010.6.0              | ACTIVE |        |
| 54d37486-447b-40e8-9321-3c53204dfda2 | Debian 7.5.0 (2014-08-29)           | ACTIVE |        |
| ba0d4a5a-91b7-4873-b496-9a4cd1f8d23c | Debian 7.9                          | ACTIVE |        |
| 119cd7a7-4e95-46b8-b3b4-cf1639005817 | Debian 8.2                          | ACTIVE |        |
| e20df6a5-3b6a-4035-81c5-e59e32618b37 | Debian 8.5.0 (2016-06-07)           | ACTIVE |        |
| 96c574ad-7bfb-4b4b-81b1-08ac12a2541d | Ubuntu 12.04.4 LTS (2015-04-06)     | ACTIVE |        |
| dd991dae-9ba9-4f66-8cfe-210e5bdc4cff | Ubuntu 12.04.5 LTS (2015-06-29)     | ACTIVE |        |
| 0e9cac82-831e-4a50-8a72-f6047b82a995 | Ubuntu 12.04.5 LTS (2015-08-26)     | ACTIVE |        |
| 6a788d7b-ec89-4944-bd24-03b9fc65e475 | Ubuntu 12.04.5 LTS (2016-02-17)     | ACTIVE |        |
| 236ef8a0-ceda-40aa-b041-167292521af6 | Ubuntu 12.04.5 LTS (2016-06-10)     | ACTIVE |        |
| dc808930-9d49-4a27-b71a-77e12a3c5b54 | Ubuntu 14.04 LTS (2015-04-06)       | ACTIVE |        |
| 72bf7ca8-47a2-4878-8253-360cf034bc41 | Ubuntu 14.04 LTS (2015-11-24)       | ACTIVE |        |
| 69c99b45-cd53-49de-afdc-f24789eb8f83 | Ubuntu 14.04.2 LTS (2015-06-17)     | ACTIVE |        |
| 8d9690dd-e8c1-4fa9-bf40-ed95e630fa55 | Ubuntu 14.04.3 LTS                  | ACTIVE |        |
| 384c3e14-74ac-4699-822b-d3569e66ea52 | Ubuntu 14.04.4 LTS (2016-02-17)     | ACTIVE |        |
| e7a734ba-b7eb-46b4-a4e1-e0860011c1ad | Ubuntu 14.04.4 LTS (2016-06-02)     | ACTIVE |        |
| 7206f305-63b9-478d-ac06-fd42570bbbcc | Ubuntu 15.04 LTS (2015-08-21)       | ACTIVE |        |
| befb9bca-c0cf-4e44-a890-2507a0550ab1 | Ubuntu 15.04 LTS (2015-09-17)       | ACTIVE |        |
| 14a01027-3c28-4d72-8605-ff54f42a9226 | Ubuntu 15.04 LTS (2015-09-23)       | ACTIVE |        |
| a1c250d9-f3dc-4c2e-a275-765697db6103 | Ubuntu 15.10 (2016-06-10)           | ACTIVE |        |
| ae5bfacd-f2d8-4a31-b45e-0d2b9c35c1b0 | Ubuntu 16.04 LTS (2016-06-10)       | ACTIVE |        |
| 22223c65-6e8a-42d4-8882-84d99d60eeed | Windows Server 2008 R2 (2014-08-29) | ACTIVE |        |
| 964e752d-a01f-41ad-8cd1-21f911a185a9 | Windows Server 2012 R2 (2014-08-29) | ACTIVE |        |
| cee5c9d4-f8ea-45c4-b806-85de7b496bb3 | cPanel/WHM (2014-08-29)             | ACTIVE |        |
+--------------------------------------+-------------------------------------+--------+--------+
```

 * ネットワーク周りの確認

```
kosuke@OpenMultiStack ~/vexxhost $ nova network-list
+--------------------------------------+--------+------+
| ID                                   | Label  | Cidr |
+--------------------------------------+--------+------+
| 6d6357ac-0f70-4afa-8bd7-c274cc4ea235 | public | -    |
+--------------------------------------+--------+------+

kosuke@OpenMultiStack ~/vexxhost $ nova floating-ip-list
+----+----+-----------+----------+------+
| Id | IP | Server Id | Fixed IP | Pool |
+----+----+-----------+----------+------+
+----+----+-----------+----------+------+

kosuke@OpenMultiStack ~/vexxhost $ neutron port-list

kosuke@OpenMultiStack ~/vexxhost $ neutron subnet-list
+--------------------------------------+----------+------------------+-------------------------------------------------------------------------+
| id                                   | name     | cidr             | allocation_pools                                                        |
+--------------------------------------+----------+------------------+-------------------------------------------------------------------------+
| 1711b9f1-adba-404e-9a72-1362a3d3380f | ipv6     | 2604:e100:1::/64 | {"start": "2604:e100:1::2", "end": "2604:e100:1:0:ffff:ffff:ffff:ffff"} |
| 636c3e9b-5988-4cca-8474-1b20411e377f | range-4  | 199.204.45.0/24  | {"start": "199.204.45.2", "end": "199.204.45.251"}                      |
| c125543f-2317-412b-b121-f40438234e9d | range-5  | 199.19.212.0/24  | {"start": "199.19.212.2", "end": "199.19.212.251"}                      |
| 765ed5dd-6f5d-47ff-b910-e9c66fe6f926 | range-8  | 199.204.46.0/24  | {"start": "199.204.46.2", "end": "199.204.46.251"}                      |
| 96684de6-61af-44a4-88ea-d9dc8b2b460e | range-9  | 162.253.53.0/24  | {"start": "162.253.53.2", "end": "162.253.53.251"}                      |
| 7092bb2a-253d-4046-9fe7-9df65674fe27 | range-3  | 199.19.213.0/24  | {"start": "199.19.213.2", "end": "199.19.213.251"}                      |
| d4872011-d34b-4541-b1f6-32381a2dffbc | range-1  | 162.253.54.0/24  | {"start": "162.253.54.2", "end": "162.253.54.251"}                      |
| 4083e5c2-41ef-4838-8844-d2d300d2fb06 | range-10 | 162.253.55.0/24  | {"start": "162.253.55.2", "end": "162.253.55.252"}                      |
| 9702aaef-a479-48f8-815a-abbc5fef9ccb | range-2  | 199.19.215.0/24  | {"start": "199.19.215.2", "end": "199.19.215.251"}                      |
| 8bf4cd85-48bb-4ccf-b2b9-0344bd23eef0 | range-6  | 162.253.52.0/24  | {"start": "162.253.52.2", "end": "162.253.52.251"}                      |
| 732715d9-3c02-4c57-ba43-72ac54c9114c | range-7  | 199.19.214.0/24  | {"start": "199.19.214.2", "end": "199.19.214.251"}                      |
+--------------------------------------+----------+------------------+-------------------------------------------------------------------------+
```

port-listコマンドは潰されているようだ。

 * security groupの追加と確認

```
kosuke@OpenMultiStack ~/vexxhost $ nova secgroup-create \
>          global_http "allow web traffic from the Internet"
+--------------------------------------+-------------+-------------------------------------+
| Id                                   | Name        | Description                         |
+--------------------------------------+-------------+-------------------------------------+
| 25a84eb2-8eb8-4435-b8c4-8c70fce0c6ed | global_http | allow web traffic from the Internet |
+--------------------------------------+-------------+-------------------------------------+
kosuke@OpenMultiStack ~/vexxhost $ nova secgroup-add-rule global_http tcp 80 80 0.0.0.0/0
+-------------+-----------+---------+-----------+--------------+
| IP Protocol | From Port | To Port | IP Range  | Source Group |
+-------------+-----------+---------+-----------+--------------+
| tcp         | 80        | 80      | 0.0.0.0/0 |              |
+-------------+-----------+---------+-----------+--------------+
kosuke@OpenMultiStack ~/vexxhost $ neutron security-group-list
+--------------------------------------+-------------+----------------------------------------------------------------------+
| id                                   | name        | security_group_rules                                                 |
+--------------------------------------+-------------+----------------------------------------------------------------------+
| 25a84eb2-8eb8-4435-b8c4-8c70fce0c6ed | global_http | egress, IPv4                                                         |
|                                      |             | egress, IPv6                                                         |
|                                      |             | ingress, IPv4, 80/tcp, remote_ip_prefix: 0.0.0.0/0                   |
| 5af6aea3-0b93-4932-8ffe-dfada368c276 | default     | egress, IPv4                                                         |
|                                      |             | egress, IPv6                                                         |
|                                      |             | ingress, IPv4                                                        |
|                                      |             | ingress, IPv4, remote_group_id: 5af6aea3-0b93-4932-8ffe-dfada368c276 |
|                                      |             | ingress, IPv6                                                        |
|                                      |             | ingress, IPv6, remote_group_id: 5af6aea3-0b93-4932-8ffe-dfada368c276 |
+--------------------------------------+-------------+----------------------------------------------------------------------+
```

 * keypairの追加と確認

```
kosuke@OpenMultiStack ~/vexxhost $ nova keypair-add vexxhost > vexxhost.pem
kosuke@OpenMultiStack ~/vexxhost $ nova keypair-list
+----------+-------------------------------------------------+
| Name     | Fingerprint                                     |
+----------+-------------------------------------------------+
| vexxhost | ad:22:2e:79:c9:34:01:99:e5:b9:c9:d1:c7:4b:a9:8d |
+----------+-------------------------------------------------+
```

 * 稼働中のすべてのインスタンスを列挙する

```
kosuke@OpenMultiStack ~/vexxhost $ nova list --all-tenants
https://gist.github.com/KosukeShimofuji/60d6d303a2a550169c6a5373777ad219
```

 * インスタンスの作成と接続

```
kosuke@OpenMultiStack ~/vexxhost $ nova boot --image "Debian 8.2" --flavor "bbcb7eb5-5c8d-498f-9d7e-307c575d3566" --key-name vexxhost sandbox.vexxhost.cloud
+--------------------------------------+------------------------------------------------------+
| Property                             | Value                                                |
+--------------------------------------+------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                               |
| OS-EXT-AZ:availability_zone          |                                                      |
| OS-EXT-STS:power_state               | 0                                                    |
| OS-EXT-STS:task_state                | scheduling                                           |
| OS-EXT-STS:vm_state                  | building                                             |
| OS-SRV-USG:launched_at               | -                                                    |
| OS-SRV-USG:terminated_at             | -                                                    |
| accessIPv4                           |                                                      |
| accessIPv6                           |                                                      |
| adminPass                            | LNMRLn4XbuCX                                         |
| config_drive                         |                                                      |
| created                              | 2016-07-21T06:10:55Z                                 |
| flavor                               | v1-standard-1 (bbcb7eb5-5c8d-498f-9d7e-307c575d3566) |
| hostId                               |                                                      |
| id                                   | 216b0e33-1330-4e46-a50d-2ddb80126114                 |
| image                                | Debian 8.2 (119cd7a7-4e95-46b8-b3b4-cf1639005817)    |
| key_name                             | vexxhost                                             |
| metadata                             | {}                                                   |
| name                                 | sandbox.vexxhost.cloud                               |
| os-extended-volumes:volumes_attached | []                                                   |
| progress                             | 0                                                    |
| security_groups                      | default                                              |
| status                               | BUILD                                                |
| tenant_id                            | f2a9ff4f366748bc8a9e39f810ff4db7                     |
| updated                              | 2016-07-21T06:10:56Z                                 |
| user_id                              | 4422d47e96974d22a8ce2aa4c64fb78f                     |
+--------------------------------------+------------------------------------------------------+

kosuke@OpenMultiStack ~/vexxhost $ nova list
+--------------------------------------+------------------------+--------+------------+-------------+----------+
| ID                                   | Name                   | Status | Task State | Power State | Networks |
+--------------------------------------+------------------------+--------+------------+-------------+----------+
| 216b0e33-1330-4e46-a50d-2ddb80126114 | sandbox.vexxhost.cloud | BUILD  | spawning   | NOSTATE     |          |
+--------------------------------------+------------------------+--------+------------+-------------+----------+

kosuke@OpenMultiStack ~/vexxhost $ nova show sandbox.vexxhost.cloud
+--------------------------------------+----------------------------------------------------------+
| Property                             | Value                                                    |
+--------------------------------------+----------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                   |
| OS-EXT-AZ:availability_zone          | ca-ymq-2                                                 |
| OS-EXT-STS:power_state               | 1                                                        |
| OS-EXT-STS:task_state                | -                                                        |
| OS-EXT-STS:vm_state                  | active                                                   |
| OS-SRV-USG:launched_at               | 2016-07-21T06:11:37.000000                               |
| OS-SRV-USG:terminated_at             | -                                                        |
| accessIPv4                           |                                                          |
| accessIPv6                           |                                                          |
| config_drive                         | True                                                     |
| created                              | 2016-07-21T06:10:55Z                                     |
| flavor                               | v1-standard-1 (bbcb7eb5-5c8d-498f-9d7e-307c575d3566)     |
| hostId                               | 8a6c1d3737ed52730c0db27877ed202f05b7acd86545ea4181bd3a31 |
| id                                   | 216b0e33-1330-4e46-a50d-2ddb80126114                     |
| image                                | Debian 8.2 (119cd7a7-4e95-46b8-b3b4-cf1639005817)        |
| key_name                             | vexxhost                                                 |
| metadata                             | {}                                                       |
| name                                 | sandbox.vexxhost.cloud                                   |
| os-extended-volumes:volumes_attached | []                                                       |
| progress                             | 0                                                        |
| public network                       | 2604:e100:1:0:f816:3eff:fe6a:ac4f, 199.204.45.196        |
| security_groups                      | default                                                  |
| status                               | ACTIVE                                                   |
| tenant_id                            | f2a9ff4f366748bc8a9e39f810ff4db7                         |
| updated                              | 2016-07-21T06:11:37Z                                     |
| user_id                              | 4422d47e96974d22a8ce2aa4c64fb78f                         |
+--------------------------------------+----------------------------------------------------------+

kosuke@OpenMultiStack ~/vexxhost $ chmod 600 vexxhost.pem
kosuke@OpenMultiStack ~/vexxhost $ ssh debian@199.204.45.196 -i ./vexxhost.pem

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Thu Jul 21 06:15:27 2016 from 221x246x62x10.ap221.ftth.ucom.ne.jp
debian@sandbox:~$
```

 * インスタンスの削除

```
kosuke@OpenMultiStack ~/vexxhost $ nova delete sandbox.vexxhost.cloud
Request to delete server sandbox.vexxhost.cloud has been accepted.
kosuke@OpenMultiStack ~/vexxhost $ nova list
+----+------+--------+------------+-------------+----------+
| ID | Name | Status | Task State | Power State | Networks |
+----+------+--------+------------+-------------+----------+
+----+------+--------+------------+-------------+----------+
```

## Conoha

 * envrcの用意

```
$ mkdir conoha
$ cd conoha
$ cat > .envrc
export OS_TENANT_NAME="SECRET"
export OS_USERNAME="SECRET"
export OS_PASSWORD="SECRET"
export OS_AUTH_URL="https://identity.tyo1.conoha.io/v2.0"
export OS_REGION_NAME="tyo1"
CTRL+C
$ direnv allow
```

 * flavorの確認

```
kosuke@OpenMultiStack ~/conoha $ nova flavor-list
+--------------------------------------+--------+-----------+------+-----------+------+-------+-------------+-----------+
| ID                                   | Name   | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public |
+--------------------------------------+--------+-----------+------+-----------+------+-------+-------------+-----------+
| 294639c7-72ba-43a5-8ff2-513c8995b869 | g-2gb  | 2048      | 50   | 0         |      | 3     | 1           | True      |
| 3aa001cd-95b6-46c9-a91e-e62d6f7f06a3 | g-16gb | 16384     | 50   | 0         |      | 8     | 1           | True      |
| 62e8fb4b-6a26-46cd-be13-e5bbf5614d15 | g-4gb  | 4096      | 50   | 0         |      | 4     | 1           | True      |
| 7eea7469-0d85-4f82-8050-6ae742394681 | g-1gb  | 1024      | 50   | 0         |      | 2     | 1           | True      |
| 965affd4-d9e8-4ffb-b9a9-624d63e2d83f | g-8gb  | 8192      | 50   | 0         |      | 6     | 1           | True      |
| a20905c6-3733-46c4-81cc-458c7dca1bae | g-32gb | 32768     | 50   | 0         |      | 12    | 1           | True      |
| c2a97b05-1b4b-4038-bbcb-343201659279 | g-64gb | 65536     | 50   | 0         |      | 24    | 1           | True      |
+--------------------------------------+--------+-----------+------+-----------+------+-------+-------------+-----------+
```

 * imageの確認

```
kosuke@OpenMultiStack ~/conoha $ nova image-list
WARNING: Command image-list is deprecated and will be removed after Nova 15.0.0 is released. Use python-glanceclient or openstackclient instead.
+--------------------------------------+----------------------------------+--------+--------+
| ID                                   | Name                             | Status | Server |
+--------------------------------------+----------------------------------+--------+--------+
| f5e5b475-ebec-4973-99c7-bc8add5d16c4 | vmi-arch-amd64                   | ACTIVE |        |
| c4984c02-598a-40f9-b9b9-9245de69da10 | vmi-basercms-3.0-centos-7.2      | ACTIVE |        |
| 49848467-c2b6-4d45-b8af-3b62dd4dbfde | vmi-centos-6.6-amd64             | ACTIVE |        |
| da1da341-d68c-4fa7-b283-70019fba6b36 | vmi-centos-6.6-i386              | ACTIVE |        |
| cd13a8b9-6b57-467b-932e-eee5edcd8d6c | vmi-centos-6.7-amd64             | ACTIVE |        |
| 9ef2815a-23a9-4647-97f0-4047b3a819a3 | vmi-centos-6.7-i386              | ACTIVE |        |
| 21113ec0-3d41-499b-8733-812eb4230e7b | vmi-centos-7-amd64               | ACTIVE |        |
| e141fc06-632e-42a9-9c2d-eec9201427ec | vmi-centos-7.2-amd64             | ACTIVE |        |
| f6419e7c-26d0-4b7d-9702-4ffa7c11dfb1 | vmi-codiad-2.7-centos-7.2        | ACTIVE |        |
| 58b8f0b3-5031-4b41-914f-5328a6c61adc | vmi-concrete5-5.7-centos-7.2     | ACTIVE |        |
| 8e43c7f6-5c32-4ebd-87db-36f9d1444536 | vmi-debian-7-amd64               | ACTIVE |        |
| 5cbfd6b8-67c0-44e3-932a-550b0f9a981a | vmi-debian-7-i386                | ACTIVE |        |
| c14d5dd5-debc-464c-9cc3-ada6e48f5d0c | vmi-debian-8-amd64               | ACTIVE |        |
| 842e6111-b5cd-4782-b423-3c68e66277b0 | vmi-debian-8-i386                | ACTIVE |        |
| be4479af-3a3f-439e-9553-4f336680ce1d | vmi-django-1.9-centos-7.2        | ACTIVE |        |
| eb597ca8-d0f4-4022-aafa-92d37ee3aed7 | vmi-docker-1.11-ubuntu-14.04     | ACTIVE |        |
| b3b42464-01c0-49bb-b360-ad4f46024775 | vmi-drone-0.3-ubuntu-14.04       | ACTIVE |        |
| 819da532-d5a3-471c-8f39-ea6864e38b48 | vmi-drupal-7.43-centos-7.2       | ACTIVE |        |
| d3878818-f15b-4298-aad3-7f7910aa83a7 | vmi-drupal-8.0-centos-7.2        | ACTIVE |        |
| ed6364b8-9fb2-479c-a5a8-bde9ba1101f3 | vmi-fedora-23-amd64              | ACTIVE |        |
| 6180dcf9-7a65-445a-9301-0882ad2f1338 | vmi-freebsd-10.1-x86_64          | ACTIVE |        |
| 831a42f5-e0ae-4d9b-9ec0-904e720fbbc3 | vmi-freebsd-10.1-zfs-x86_64      | ACTIVE |        |
| e81f3ed7-07a1-4096-aaed-3b27ad7e5ba7 | vmi-gitlab-8.5-centos-7          | ACTIVE |        |
| ec4b8b29-2a8f-426f-b865-0839fdf655d9 | vmi-hadoop-2.6-master-centos-6.6 | ACTIVE |        |
| acfb0e18-2be5-4f35-b073-af7ecd252bfb | vmi-hadoop-2.6-slave-centos-6.6  | ACTIVE |        |
| 824db940-5ad0-4840-a8c0-4aa2567f9991 | vmi-hatohol-16.01-centos7.2      | ACTIVE |        |
| e96ad395-d9c9-49f6-8237-ef5b075cfc6a | vmi-hinemos-5.0-centos-7.2       | ACTIVE |        |
| 91ec6e8e-6f41-42ae-8e39-f5318aa405cc | vmi-hubot-2.18-centos-7.2        | ACTIVE |        |
| cb60f7cc-1954-4c50-9b64-bb75d878c110 | vmi-jenkins-1.6-centos-7.2       | ACTIVE |        |
| d8e84913-db9f-44ee-887e-32ffe8dab54f | vmi-joomla-3.5-centos-7.2        | ACTIVE |        |
| 82363313-5e20-4709-a5d3-43984397c870 | vmi-lamp-centos-7.2              | ACTIVE |        |
| ffe63e99-9bda-4bc3-908b-a34e8ffd9e98 | vmi-meanjs-latest-centos-7.2     | ACTIVE |        |
| fc3c5233-5621-4bcf-bb41-35197ccd50fe | vmi-mongodb-3.2-centos-7         | ACTIVE |        |
| 89d0bdf1-714c-4dcc-9ae6-bfaf192ce1e1 | vmi-mosquitto-1.4-centos-7.2     | ACTIVE |        |
| ac3cdd29-d715-4af5-a283-11d5519fd87e | vmi-netbsd-7.0-amd64             | ACTIVE |        |
| 22fa65b1-4061-4900-95ee-7e6cc61b02ae | vmi-openbsd-5.8-amd64            | ACTIVE |        |
| 8700e968-ace2-4397-a917-6b34bfe1c6be | vmi-opensuse-42.1-amd64          | ACTIVE |        |
| bfe54660-5d24-48ca-bf8c-e741d8027b48 | vmi-owncloud-9.0-centos-7.2      | ACTIVE |        |
| 5a569864-62d8-42a3-92ba-8bde48ee1a01 | vmi-piwik-2.16-centos-7.2        | ACTIVE |        |
| b46716a0-1be6-4f88-932d-6a2c9eeb25d0 | vmi-rails-4.2-centos-7.2         | ACTIVE |        |
| d4257898-b35d-4a56-8c1d-9e039009bca0 | vmi-redis-3.0-centos-7.2         | ACTIVE |        |
| a80661d6-7269-4756-9c9e-59219f7391a4 | vmi-redmine-3.2-centos-7.2       | ACTIVE |        |
| d7810c4a-614e-433a-936d-ff6cd6b2cd0c | vmi-scientific-7.2-amd64         | ACTIVE |        |
| cb5308e0-fc03-412a-b7d4-382d54ca7756 | vmi-trac-1.0-centos-7.2          | ACTIVE |        |
| b6a8a76b-c2ef-445d-a81f-19547eeb1301 | vmi-ubuntu-12.04-amd64           | ACTIVE |        |
| ddec4c3d-5e9c-46fb-bfe7-5362e058067d | vmi-ubuntu-12.04-i386            | ACTIVE |        |
| 793be3e1-3c33-4ab3-9779-f4098ea90eb5 | vmi-ubuntu-14.04-amd64           | ACTIVE |        |
| e5b34609-becb-415a-9818-b6e29f4d877a | vmi-ubuntu-14.04-i386            | ACTIVE |        |
| 437db1dd-3c94-45ae-99c9-c0a3742913a0 | vmi-wordpress-kusanagi-centos-7  | ACTIVE |        |
| ac965a99-7318-44e2-b61c-60788213e9bc | vmi-zabbix-2.4-centos-7.2        | ACTIVE |        |
+--------------------------------------+----------------------------------+--------+--------+
```

 * ネットワーク周りの確認

```

kosuke@OpenMultiStack ~/conoha $  nova net-list
ERROR (NotFound): Not found (HTTP 404)
kosuke@OpenMultiStack ~/conoha $ nova floating-ip-list
ERROR (NotFound): Not found (HTTP 404)
kosuke@OpenMultiStack ~/conoha $ neutron port-list

kosuke@OpenMultiStack ~/conoha $ neutron subnet-list
+--------------------------------------+---------------------------+-------------------------+--------------------------------------------------------------------------------------+
| id                                   | name                      | cidr                    | allocation_pools                                                                     |
+--------------------------------------+---------------------------+-------------------------+--------------------------------------------------------------------------------------+
| 0569c47a-d349-4a23-a45b-ae9a50d9d847 | ext-133-130-48-0-23       | 133.130.48.0/23         | {"start": "133.130.48.16", "end": "133.130.49.240"}                                  |
| 059d0afa-f8f7-4440-bd8f-85d1d2dc4fdf | ext-2400-8500-1301-730-64 | 2400:8500:1301:730::/64 | {"start": "2400:8500:1301:730::16", "end": "2400:8500:1301:730:ffff:ffff:ffff:fffe"} |
| 067e58eb-abed-4c15-9813-deec2d614ef4 | ext-133-130-54-0-23       | 133.130.54.0/23         | {"start": "133.130.54.16", "end": "133.130.55.240"}                                  |
| 0866c8fb-aeb2-464a-9f3b-5feb6649021a | ext-2400-8500-1301-729-64 | 2400:8500:1301:729::/64 | {"start": "2400:8500:1301:729::16", "end": "2400:8500:1301:729:ffff:ffff:ffff:fffe"} |
| 1204865f-a990-4601-8817-7b98d301248b | ext-133-130-122-0-23      | 133.130.122.0/23        | {"start": "133.130.122.16", "end": "133.130.123.240"}                                |
| 1209f92f-3c19-4153-8dcb-5ff9baadca39 | ext-163-44-170-0-23       | 163.44.170.0/23         | {"start": "163.44.170.16", "end": "163.44.171.240"}                                  |
| 14e55545-709d-4312-8655-0d9665e52638 | ext-133-130-88-0-23       | 133.130.88.0/23         | {"start": "133.130.88.16", "end": "133.130.89.240"}                                  |
| 155573cc-30a8-4f25-a269-9921baa1654c | ext-2400-8500-1301-736-64 | 2400:8500:1301:736::/64 | {"start": "2400:8500:1301:736::16", "end": "2400:8500:1301:736:ffff:ffff:ffff:fffe"} |
| 176f326e-3d3b-48c6-a206-fe98f63c24ae | ext-2400-8500-1301-749-64 | 2400:8500:1301:749::/64 | {"start": "2400:8500:1301:749::16", "end": "2400:8500:1301:749:ffff:ffff:ffff:fffe"} |
| 1f41a90d-fbd5-42ec-bd75-ce428f638742 | ext-150-95-128-0-23       | 150.95.128.0/23         | {"start": "150.95.128.16", "end": "150.95.129.240"}                                  |
| 206da8fc-abbb-45ac-a56b-c1fac6c6fd8f | ext-2400-8500-1301-747-64 | 2400:8500:1301:747::/64 | {"start": "2400:8500:1301:747::16", "end": "2400:8500:1301:747:ffff:ffff:ffff:fffe"} |
| 20fedbe4-b78b-4845-b0fd-6d7f3cac8523 | ext-133-130-120-0-23      | 133.130.120.0/23        | {"start": "133.130.120.16", "end": "133.130.121.240"}                                |
| 2185d234-3e84-4b78-a34d-1748973c706d | ext-2400-8500-1302-801-64 | 2400:8500:1302:801::/64 | {"start": "2400:8500:1302:801::16", "end": "2400:8500:1302:801:ffff:ffff:ffff:fffe"} |
| 21f2b045-62d7-403a-92f7-572c6f9a2652 | ext-2400-8500-1302-814-64 | 2400:8500:1302:814::/64 | {"start": "2400:8500:1302:814::16", "end": "2400:8500:1302:814:ffff:ffff:ffff:fffe"} |
| 2ee5209d-0250-4d11-9619-a32e5d2f6c1f | ext-2400-8500-1302-818-64 | 2400:8500:1302:818::/64 | {"start": "2400:8500:1302:818::16", "end": "2400:8500:1302:818:ffff:ffff:ffff:fffe"} |
| 30ea13d0-8315-4843-b332-321407f13a3c | shared-172-21-142-0-23    | 172.21.142.0/23         | {"start": "172.21.142.16", "end": "172.21.143.240"}                                  |
| 31f51278-6ab5-45a2-a3c7-2f786d958b4f | ext-133-130-108-0-23      | 133.130.108.0/23        | {"start": "133.130.108.16", "end": "133.130.109.240"}                                |
| 32995018-7f5c-4782-aa2f-79c9dbb3b74a | ext-133-130-124-0-23      | 133.130.124.0/23        | {"start": "133.130.124.16", "end": "133.130.125.240"}                                |
| 38dfc9f8-72a9-4e9c-aaab-fd972da06fb8 | ext-2400-8500-1301-746-64 | 2400:8500:1301:746::/64 | {"start": "2400:8500:1301:746::16", "end": "2400:8500:1301:746:ffff:ffff:ffff:fffe"} |
| 3b4925eb-d140-4ef5-8ec2-fa3dd599c739 | ext-2400-8500-1301-735-64 | 2400:8500:1301:735::/64 | {"start": "2400:8500:1301:735::16", "end": "2400:8500:1301:735:ffff:ffff:ffff:fffe"} |
| 45093c6d-e0cf-4101-943b-c75625a57801 | shared-172-21-138-0-23    | 172.21.138.0/23         | {"start": "172.21.138.16", "end": "172.21.139.240"}                                  |
| 4a776334-58a2-48d4-a854-9fc88313652c | ext-2400-8500-1301-740-64 | 2400:8500:1301:740::/64 | {"start": "2400:8500:1301:740::16", "end": "2400:8500:1301:740:ffff:ffff:ffff:fffe"} |
| 4e629573-1b82-487c-a941-4729f8ac65dc | ext-2400-8500-1302-800-64 | 2400:8500:1302:800::/64 | {"start": "2400:8500:1302:800::16", "end": "2400:8500:1302:800:ffff:ffff:ffff:fffe"} |
| 4e6b5a68-f25b-45a0-8690-961a95aa1adf | shared-172-21-140-0-23    | 172.21.140.0/23         | {"start": "172.21.140.16", "end": "172.21.141.240"}                                  |
| 53a21d07-e9fc-4bb2-9d14-a3c844078dbe | ext-133-130-110-0-23      | 133.130.110.0/23        | {"start": "133.130.110.16", "end": "133.130.111.240"}                                |
| 54d345de-165a-40ec-b3a6-0233edcf1308 | ext-133-130-106-0-23      | 133.130.106.0/23        | {"start": "133.130.106.16", "end": "133.130.107.240"}                                |
| 57fcb428-c5ee-4870-8d8d-e5232a64be80 | ext-2400-8500-1302-802-64 | 2400:8500:1302:802::/64 | {"start": "2400:8500:1302:802::16", "end": "2400:8500:1302:802:ffff:ffff:ffff:fffe"} |
| 59800914-e35d-482c-9ec6-817dfa617154 | ext-2400-8500-1302-803-64 | 2400:8500:1302:803::/64 | {"start": "2400:8500:1302:803::16", "end": "2400:8500:1302:803:ffff:ffff:ffff:fffe"} |
| 5e9ab6f1-58ff-4675-9d19-4d9586e58126 | ext-2400-8500-1301-737-64 | 2400:8500:1301:737::/64 | {"start": "2400:8500:1301:737::16", "end": "2400:8500:1301:737:ffff:ffff:ffff:fffe"} |
| 5ec79724-4f8a-4446-8721-be96c7646654 | ext-2400-8500-1302-811-64 | 2400:8500:1302:811::/64 | {"start": "2400:8500:1302:811::16", "end": "2400:8500:1302:811:ffff:ffff:ffff:fffe"} |
| 640add09-24d7-429b-876d-09e115ee5ebf | ext-163-44-164-0-23       | 163.44.164.0/23         | {"start": "163.44.164.16", "end": "163.44.165.240"}                                  |
| 6d452691-d87a-4c64-a5b0-eaa11619c509 | ext-2400-8500-1301-738-64 | 2400:8500:1301:738::/64 | {"start": "2400:8500:1301:738::16", "end": "2400:8500:1301:738:ffff:ffff:ffff:fffe"} |
| 6ead51c1-582a-49ef-8026-203744c8402d | ext-2400-8500-1301-727-64 | 2400:8500:1301:727::/64 | {"start": "2400:8500:1301:727::16", "end": "2400:8500:1301:727:ffff:ffff:ffff:fffe"} |
| 7091c5f6-b874-4ddc-a615-708f8b590281 | ext-150-95-132-0-23       | 150.95.132.0/23         | {"start": "150.95.132.16", "end": "150.95.133.240"}                                  |
| 7ce4aa5e-b0fb-4214-8a25-30d032c83464 | ext-163-44-168-0-23       | 163.44.168.0/23         | {"start": "163.44.168.16", "end": "163.44.169.240"}                                  |
| 842b68af-ddb1-474d-b0ab-f8fb68ac6097 | ext-133-130-116-0-23      | 133.130.116.0/23        | {"start": "133.130.116.16", "end": "133.130.117.240"}                                |
| 87a3ded1-897d-4a0e-aeea-df01ca37eb10 | ext-133-130-102-0-23      | 133.130.102.0/23        | {"start": "133.130.102.16", "end": "133.130.103.240"}                                |
| 8be09904-2500-4033-8ee0-e0bf87bc7502 | ext-2400-8500-1302-816-64 | 2400:8500:1302:816::/64 | {"start": "2400:8500:1302:816::16", "end": "2400:8500:1302:816:ffff:ffff:ffff:fffe"} |
| 8fb1c9f6-e3c3-4144-b9d1-f1183be54377 | ext-2400-8500-1302-812-64 | 2400:8500:1302:812::/64 | {"start": "2400:8500:1302:812::16", "end": "2400:8500:1302:812:ffff:ffff:ffff:fffe"} |
| 93e055fc-c488-4043-b24d-ce7e20ab9fd2 | ext-2400-8500-1301-704-64 | 2400:8500:1301:704::/64 | {"start": "2400:8500:1301:704::16", "end": "2400:8500:1301:704:ffff:ffff:ffff:fffe"} |
| 94673021-811f-4d5c-8792-189a85ed6b18 | ext-133-130-112-0-23      | 133.130.112.0/23        | {"start": "133.130.112.16", "end": "133.130.113.240"}                                |
| a2c7d2a7-8b56-4396-8fc1-4ee707c036fe | ext-150-95-130-0-23       | 150.95.130.0/23         | {"start": "150.95.130.16", "end": "150.95.131.240"}                                  |
| a3e99510-4ce4-486b-af9b-c2c253b29a39 | ext-157-7-108-0-23        | 157.7.108.0/23          | {"start": "157.7.108.16", "end": "157.7.109.240"}                                    |
| a69efe3b-0b71-4401-b04c-7d1ec8d8b63c | ext-133-130-98-0-23       | 133.130.98.0/23         | {"start": "133.130.98.16", "end": "133.130.99.240"}                                  |
| a9acc160-36c2-4c66-b66d-43f413cb2a23 | ext-133-130-58-0-23       | 133.130.58.0/23         | {"start": "133.130.58.16", "end": "133.130.59.240"}                                  |
| ae494681-aa99-44da-a0e0-cc2ac50aae03 | shared-172-21-114-0-23    | 172.21.114.0/23         | {"start": "172.21.114.16", "end": "172.21.115.240"}                                  |
| af67a500-72c6-4605-b20c-16b5e3fd2ffc | ext-2400-8500-1301-748-64 | 2400:8500:1301:748::/64 | {"start": "2400:8500:1301:748::16", "end": "2400:8500:1301:748:ffff:ffff:ffff:fffe"} |
| b03103f6-4ce1-431b-8faf-039262beb594 | ext-133-130-52-0-23       | 133.130.52.0/23         | {"start": "133.130.52.16", "end": "133.130.53.240"}                                  |
| b1154708-20b6-4545-bb3f-cb7ce38b5363 | ext-133-130-96-0-23       | 133.130.96.0/23         | {"start": "133.130.96.16", "end": "133.130.97.240"}                                  |
| bc781e7b-729e-46b0-a308-2688c04f4618 | ext-2400-8500-1301-732-64 | 2400:8500:1301:732::/64 | {"start": "2400:8500:1301:732::16", "end": "2400:8500:1301:732:ffff:ffff:ffff:fffe"} |
| c1b9076f-65a7-4210-b393-68fe8132ca6e | ext-2400-8500-1301-743-64 | 2400:8500:1301:743::/64 | {"start": "2400:8500:1301:743::16", "end": "2400:8500:1301:743:ffff:ffff:ffff:fffe"} |
| c730d402-b7cf-49df-8b0d-519175e510c5 | ext-2400-8500-1301-744-64 | 2400:8500:1301:744::/64 | {"start": "2400:8500:1301:744::16", "end": "2400:8500:1301:744:ffff:ffff:ffff:fffe"} |
| caf9eddb-bbdf-4ad5-bc65-050f526315ce | ext-163-44-166-0-23       | 163.44.166.0/23         | {"start": "163.44.166.16", "end": "163.44.167.240"}                                  |
| cbc6420c-1788-47ca-b4c3-77e893e44d2d | ext-133-130-114-0-23      | 133.130.114.0/23        | {"start": "133.130.114.16", "end": "133.130.115.240"}                                |
| d0b1e1a9-ed11-412f-8a7b-b4d3a21ed808 | ext-2400-8500-1302-815-64 | 2400:8500:1302:815::/64 | {"start": "2400:8500:1302:815::16", "end": "2400:8500:1302:815:ffff:ffff:ffff:fffe"} |
| d52729f7-dafc-4414-b2e3-ae2b4439d646 | ext-2400-8500-1301-739-64 | 2400:8500:1301:739::/64 | {"start": "2400:8500:1301:739::16", "end": "2400:8500:1301:739:ffff:ffff:ffff:fffe"} |
| da74c8f6-e69d-493b-8e61-4b125f55c75b | ext-2400-8500-1301-731-64 | 2400:8500:1301:731::/64 | {"start": "2400:8500:1301:731::16", "end": "2400:8500:1301:731:ffff:ffff:ffff:fffe"} |
| dc6c096d-653f-48ac-8987-18ff40a0eac0 | ext-2400-8500-1301-734-64 | 2400:8500:1301:734::/64 | {"start": "2400:8500:1301:734::16", "end": "2400:8500:1301:734:ffff:ffff:ffff:fffe"} |
| decac8e2-19df-496a-96d0-83519e212441 | ext-163-44-172-0-23       | 163.44.172.0/23         | {"start": "163.44.172.16", "end": "163.44.173.240"}                                  |
| e5037543-b23f-4c88-b65e-aa59a500dd01 | ext-133-130-56-0-23       | 133.130.56.0/23         | {"start": "133.130.56.16", "end": "133.130.57.240"}                                  |
| e60e0264-9948-4fd1-a222-c26416b3295f | ext-133-130-100-0-23      | 133.130.100.0/23        | {"start": "133.130.100.16", "end": "133.130.101.240"}                                |
| e9b2a13f-ae74-4ee4-8bd9-2a4106c6442c | ext-2400-8500-1302-817-64 | 2400:8500:1302:817::/64 | {"start": "2400:8500:1302:817::16", "end": "2400:8500:1302:817:ffff:ffff:ffff:fffe"} |
| ec959095-db68-4e35-9120-60848c0c0a81 | ext-133-130-62-0-23       | 133.130.62.0/23         | {"start": "133.130.62.16", "end": "133.130.63.240"}                                  |
| efe7373d-e97f-4ee7-829f-5613c76c04c9 | ext-133-130-126-0-23      | 133.130.126.0/23        | {"start": "133.130.126.16", "end": "133.130.127.240"}                                |
| f260150e-2085-40b0-86c8-67319e7ccfd6 | ext-2400-8500-1302-810-64 | 2400:8500:1302:810::/64 | {"start": "2400:8500:1302:810::16", "end": "2400:8500:1302:810:ffff:ffff:ffff:fffe"} |
| f3b9b52d-fd32-4822-9e93-a562e27bd4e2 | ext-163-44-174-0-23       | 163.44.174.0/23         | {"start": "163.44.174.16", "end": "163.44.175.240"}                                  |
| f4416f3e-5441-4ed3-9c24-5a3d2c7e9475 | ext-2400-8500-1302-813-64 | 2400:8500:1302:813::/64 | {"start": "2400:8500:1302:813::16", "end": "2400:8500:1302:813:ffff:ffff:ffff:fffe"} |
| faa308cf-5760-4964-b5c3-2f7cd3a97c02 | ext-133-130-90-0-23       | 133.130.90.0/23         | {"start": "133.130.90.16", "end": "133.130.91.240"}                                  |
| fbc90633-b038-423c-8708-2d19f66de160 | ext-2400-8500-1301-745-64 | 2400:8500:1301:745::/64 | {"start": "2400:8500:1301:745::16", "end": "2400:8500:1301:745:ffff:ffff:ffff:fffe"} |
| ff6e1f14-bc8a-44ba-8987-eaea9344bb0d | ext-133-130-118-0-23      | 133.130.118.0/23        | {"start": "133.130.118.16", "end": "133.130.119.240"}                                |
+--------------------------------------+---------------------------+-------------------------+--------------------------------------------------------------------------------------+
```

取れる情報はvexxbostと同じであることがわかった。

 * security groupの追加と確認

```
$ nova secgroup-create \
> >          global_http "allow web traffic from the Internet"
usage: nova secgroup-create <name> <description>
error: the following arguments are required: <description>
Try 'nova help secgroup-create' for more information.
kosuke@OpenMultiStack ~/conoha $ neutron security-group-list
+--------------------------------------+---------------+----------------------------------------------------------------------+
| id                                   | name          | security_group_rules                                                 |
+--------------------------------------+---------------+----------------------------------------------------------------------+
| 1e249409-13dd-4add-8c13-925768f4ad6a | test-sg       | egress, IPv4                                                         |
|                                      |               | egress, IPv6                                                         |
|                                      |               | ingress, IPv4, 22/tcp, remote_ip_prefix: 0.0.0.0/0                   |
|                                      |               | ingress, IPv4, icmp, remote_ip_prefix: 0.0.0.0/0                     |
| 2592bf81-deaf-4333-9614-54c0eb3ba43e | gncs-ipv4-all | egress, IPv4                                                         |
|                                      |               | egress, IPv6                                                         |
|                                      |               | ingress, IPv4                                                        |
| 2d66d24e-6c1c-48a3-ab6d-39d427057f2d | gncs-ipv6-ssh | egress, IPv4                                                         |
|                                      |               | egress, IPv6                                                         |
|                                      |               | ingress, IPv6, 22/tcp                                                |
| d2646c53-b60f-45a4-8429-421a8c3c06eb | gncs-ipv6-all | egress, IPv4                                                         |
|                                      |               | egress, IPv6                                                         |
|                                      |               | ingress, IPv6                                                        |
| e553398c-958f-49ed-beb8-dcfc75ade1a1 | gncs-ipv4-ssh | egress, IPv4                                                         |
|                                      |               | egress, IPv6                                                         |
|                                      |               | ingress, IPv4, 22/tcp                                                |
| f8d24f3f-e254-42b5-9018-0e72877e8009 | default       | egress, IPv4                                                         |
|                                      |               | egress, IPv6                                                         |
|                                      |               | ingress, IPv4, remote_group_id: f8d24f3f-e254-42b5-9018-0e72877e8009 |
|                                      |               | ingress, IPv6, remote_group_id: f8d24f3f-e254-42b5-9018-0e72877e8009 |
+--------------------------------------+---------------+----------------------------------------------------------------------+
```

vexxhostではできたセキュリティグループの追加はAPIから行うことはできないので、webインターフェイスから行うことになる。

 * keypairの追加と確認

```
kosuke@OpenMultiStack ~/conoha $ nova keypair-add conoha > conoha.pem
kosuke@OpenMultiStack ~/conoha $ nova keypair-list
+---------------+-------------------------------------------------+
| Name          | Fingerprint                                     |
+---------------+-------------------------------------------------+
| conoha        | 54:d8:0b:fc:4b:b3:e6:5c:a9:1a:4a:16:62:5e:28:44 |
| key-temporary | 9d:89:86:f6:2d:73:a3:f1:aa:b6:6d:38:2e:83:16:02 |
+---------------+-------------------------------------------------+
```

 * すべての稼働中のインスタンスを列挙する

```
$ nova list --all-tenants
+--------------------------------------+-----------------+----------------------------------+--------+------------+-------------+--------------------------------------------------------------------------+
| ID                                   | Name            | Tenant ID                        | Status | Task State | Power State | Networks                                                                 |
+--------------------------------------+-----------------+----------------------------------+--------+------------+-------------+--------------------------------------------------------------------------+
| de80b7e1-dc9a-4de2-b079-228ec1c544a1 | 133-130-103-230 | 23fdcfdea20f41b4bbef4da336eb0f05 | ACTIVE | -          | Running     | ext-133-130-102-0-23=2400:8500:1301:738:133:130:103:230, 133.130.103.230 |
+--------------------------------------+-----------------+----------------------------------+--------+------------+-------------+--------------------------------------------------------------------------+
```

vexxhostはテナントの枠を超えてすべてのインスタンスを取得することができたが、Conohaでは改善されている

 * インスタンスの作成と接続

```
kosuke@OpenMultiStack ~/conoha $ nova boot --image "vmi-debian-8-amd64" --flavor "g-1gb" --key-name conoha sandbox.conoha.cloud
+--------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Property                             | Value                                                                                                                                                                                                                                                  |
+--------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                                                                                                                                                                                                                 |
| OS-EXT-AZ:availability_zone          | nova                                                                                                                                                                                                                                                   |
| OS-EXT-SRV-ATTR:host                 |                                                                                                                                                                                                                                                        |
| OS-EXT-SRV-ATTR:hypervisor_hostname  |                                                                                                                                                                                                                                                        |
| OS-EXT-SRV-ATTR:instance_name        | tyo1-000772f8                                                                                                                                                                                                                                          |
| OS-EXT-STS:power_state               | 0                                                                                                                                                                                                                                                      |
| OS-EXT-STS:task_state                | scheduling                                                                                                                                                                                                                                             |
| OS-EXT-STS:vm_state                  | building                                                                                                                                                                                                                                               |
| OS-SRV-USG:launched_at               | -                                                                                                                                                                                                                                                      |
| OS-SRV-USG:terminated_at             | -                                                                                                                                                                                                                                                      |
| accessIPv4                           |                                                                                                                                                                                                                                                        |
| accessIPv6                           |                                                                                                                                                                                                                                                        |
| adminPass                            | 3To@UEPgH                                                                                                                                                                                                                                              |
| config_drive                         | True                                                                                                                                                                                                                                                   |
| created                              | 2016-07-21T06:58:35Z                                                                                                                                                                                                                                   |
| flavor                               | g-1gb (7eea7469-0d85-4f82-8050-6ae742394681)                                                                                                                                                                                                           |
| hostId                               |                                                                                                                                                                                                                                                        |
| id                                   | de80b7e1-dc9a-4de2-b079-228ec1c544a1                                                                                                                                                                                                                   |
| image                                | vmi-debian-8-amd64 (c14d5dd5-debc-464c-9cc3-ada6e48f5d0c)                                                                                                                                                                                              |
| key_name                             | conoha                                                                                                                                                                                                                                                 |
| metadata                             | {"backup_id": "", "backup_set": "0", "instance_name_tag": "133-130-103-230", "backup_status": "active", "properties": "{\"vnc_keymap\":\"ja\",\"hw_video_model\":\"vga\",\"hw_vif_model\":\"virtio\",\"hw_disk_bus\":\"virtio\",\"cdrom_path\":\"\"}"} |
| name                                 | 133-130-103-230                                                                                                                                                                                                                                        |
| os-extended-volumes:volumes_attached | []                                                                                                                                                                                                                                                     |
| progress                             | 0                                                                                                                                                                                                                                                      |
| security_groups                      | default                                                                                                                                                                                                                                                |
| status                               | BUILD                                                                                                                                                                                                                                                  |
| tenant_id                            | 23fdcfdea20f41b4bbef4da336eb0f05                                                                                                                                                                                                                       |
| updated                              | 2016-07-21T06:58:36Z                                                                                                                                                                                                                                   |
| user_id                              | 768ce130012d41979e90a2d3949a501f                                                                                                                                                                                                                       |
+--------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

Conohaはセキュリティグループの割り当てを行わないと、デフォルトではSSH接続することはできない。この問題は起動時にセキュリティグループを設定することで回避することができるのは確認している。

```
 kosuke@OpenMultiStack ~/conoha $ nova boot --image "vmi-debian-8-amd64" --flavor "g-1gb" --key-name conoha sandbox.conoha.cloud --security-groups gncs-ipv4-all
+--------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Property                             | Value                                                                                                                                                                                                                                                  |
+--------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                                                                                                                                                                                                                 |
| OS-EXT-AZ:availability_zone          | nova                                                                                                                                                                                                                                                   |
| OS-EXT-SRV-ATTR:host                 |                                                                                                                                                                                                                                                        |
| OS-EXT-SRV-ATTR:hypervisor_hostname  |                                                                                                                                                                                                                                                        |
| OS-EXT-SRV-ATTR:instance_name        | tyo1-0007730a                                                                                                                                                                                                                                          |
| OS-EXT-STS:power_state               | 0                                                                                                                                                                                                                                                      |
| OS-EXT-STS:task_state                | scheduling                                                                                                                                                                                                                                             |
| OS-EXT-STS:vm_state                  | building                                                                                                                                                                                                                                               |
| OS-SRV-USG:launched_at               | -                                                                                                                                                                                                                                                      |
| OS-SRV-USG:terminated_at             | -                                                                                                                                                                                                                                                      |
| accessIPv4                           |                                                                                                                                                                                                                                                        |
| accessIPv6                           |                                                                                                                                                                                                                                                        |
| adminPass                            | gNY_iIzfw                                                                                                                                                                                                                                              |
| config_drive                         | True                                                                                                                                                                                                                                                   |
| created                              | 2016-07-21T07:31:44Z                                                                                                                                                                                                                                   |
| flavor                               | g-1gb (7eea7469-0d85-4f82-8050-6ae742394681)                                                                                                                                                                                                           |
| hostId                               |                                                                                                                                                                                                                                                        |
| id                                   | 4b9cf133-89a7-427c-8e1a-2b08b2f0943f                                                                                                                                                                                                                   |
| image                                | vmi-debian-8-amd64 (c14d5dd5-debc-464c-9cc3-ada6e48f5d0c)                                                                                                                                                                                              |
| key_name                             | conoha                                                                                                                                                                                                                                                 |
| metadata                             | {"backup_status": "active", "backup_id": "", "backup_set": "0", "instance_name_tag": "133-130-113-209", "properties": "{\"vnc_keymap\":\"ja\",\"hw_video_model\":\"vga\",\"hw_vif_model\":\"virtio\",\"hw_disk_bus\":\"virtio\",\"cdrom_path\":\"\"}"} |
| name                                 | 133-130-113-209                                                                                                                                                                                                                                        |
| os-extended-volumes:volumes_attached | []                                                                                                                                                                                                                                                     |
| progress                             | 0                                                                                                                                                                                                                                                      |
| security_groups                      | gncs-ipv4-all                                                                                                                                                                                                                                          |
| status                               | BUILD                                                                                                                                                                                                                                                  |
| tenant_id                            | 23fdcfdea20f41b4bbef4da336eb0f05                                                                                                                                                                                                                       |
| updated                              | 2016-07-21T07:31:45Z                                                                                                                                                                                                                                   |
| user_id                              | 768ce130012d41979e90a2d3949a501f                                                                                                                                                                                                                       |
+--------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
kosuke@OpenMultiStack ~/conoha $ chmod 600 conoha.pem
kosuke@OpenMultiStack ~/conoha $ ssh root@133.130.113.209 -i conoha.pem

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
-bash: warning: setlocale: LC_ALL: cannot change locale (ja_JP.UTF-8)
_____________________________________________________________________
WARNING! Your environment specifies an invalid locale.
 This can affect your user experience significantly, including the
 ability to manage packages. You may install the locales by running:

   sudo apt-get install language-pack-ja
     or
   sudo locale-gen ja_JP.UTF-8

To see all available language packs, run:
   apt-cache search "^language-pack-[a-z][a-z]$"
To disable this message for all users, run:
   sudo touch /var/lib/cloud/instance/locale-check.skip
_____________________________________________________________________

-bash: warning: setlocale: LC_ALL: cannot change locale (ja_JP.UTF-8)
root@133-130-113-209:~#
```

もう一つ気をつけておかないといけないのは、Conohaは任意のインスタンス名を指定しても、Conoha側で勝手に名前をIPv4に基づく名前に変更されるということは覚えておいたほうがいい。

```
(OpenMultiStack) kosuke@OpenMultiStack ~/conoha $ nova delete 133-130-113-209
Request to delete server 133-130-113-209 has been accepted.
(OpenMultiStack) kosuke@OpenMultiStack ~/conoha $ nova list
+----+------+--------+------------+-------------+----------+
| ID | Name | Status | Task State | Power State | Networks |
+----+------+--------+------------+-------------+----------+
+----+------+--------+------------+-------------+----------+
```

# APIに着目した調査のまとめ

vexxhostとconohaについて私がよく使うAPIについて比較を行ったが、細かなところで差異が存在する。openstack public cloud providerを複数またいで使うような場合は、この差異を考えて共通化する必要がある。

# 参考文献

 * http://docs.openstack.org/developer/os-client-config/vendor-support.html
 * http://docs.openstack.org/ja/openstack-ops/content/openstack-ops_preface.html


