---
layout: post
title:  "DockerコンテナにSSH接続する"
date:   2016-08-18 12:00:00 +0900
categories: development
---

OpenStack上にDockerを起動させて、1つのcompute nodeの上に複数のdockerコンテナを動かして、それぞれとSSH通信がしたい。どうすれば実現できるのかを本エントリで調査する。

# docker-engineのインストール

debianにdocker-engineをインストールする手順は[公式のドキュメント](https://docs.docker.com/engine/installation/linux/debian/)に詳しく記述されているので、参照する。
公式の手順はansibleに[落とし込んだ](https://github.com/KosukeShimofuji/dockerhost/blob/master/ansible/roles/docker_engine/tasks/main.yml)。

```
kosuke@dockerhost ~ $ sudo docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/
```

# SSHデーモン入りのコンテナを作成する

```
# docker pull debian
# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
debian              latest              1b01529cc499        11 days ago         125.1 MB
hello-world         latest              c54a2cc56cbb        5 weeks ago         1.848 kB
# docker run -i -t debian /bin/bash
root@1cdcc20a00e8:/# apt-get update
root@1cdcc20a00e8:/# apt-get install openssh-server
root@1cdcc20a00e8:/# adduser guest
root@1cdcc20a00e8:/# exit
# docker commit $(docker ps -l -q) debian/sshd
sha256:640ca592177786246e62de04d96aa8600cf77d2d507d6a82ff90382b1bd41dcd
# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
debian/sshd         latest              640ca5921777        About a minute ago   155.1 MB
debian              latest              1b01529cc499        2 weeks ago          125.1 MB
hello-world         latest              c54a2cc56cbb        6 weeks ago          1.848 kB
# docker run -p 0.0.0.0:2200:22 -d debian/sshd /usr/sbin/sshd -D
# netstat -lnp | grep 2200
tcp        0      0 127.0.0.1:2200          0.0.0.0:*               LISTEN 22502/docker-proxy
```

 * dockerhostからの接続確認

```
root@dockerhost:~# ssh guest@127.0.0.1 -p 2200
guest@127.0.0.1's password:

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Thu Aug 18 03:38:56 2016 from 172.17.0.1
-bash: warning: setlocale: LC_ALL: cannot change locale (ja_JP.UTF-8)
```

 * 外部ホストからの接続確認

```
$ ssh guest@dockerhost.test -p 2200
The authenticity of host '[dockerhost.test]:2200 ([192.168.10.111]:2200)' can't be established.
ECDSA key fingerprint is SHA256:XU2QKJ4L2B+uhoknv7Um2H7+x8mcTj8XzwkVHh3qVE4.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[dockerhost.test]:2200,[192.168.10.111]:2200' (ECDSA) to the list of known hosts.
guest@dockerhost.test's password:

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Thu Aug 18 03:43:00 2016 from 172.17.0.1
-bash: warning: setlocale: LC_ALL: cannot change locale (ja_JP.UTF-8)
guest@75cc8b06ac09:~$

```

# 起動中のコンテナにログインする

```
# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
4d739a6f5605        debian/sshd         "/bin/bash"         5 seconds ago       Up 4 seconds        127.0.0.1:2200->22/tcp   amazing_stonebraker
# docker exec -it 4d739a6f5605 /bin/bash
```

# 起動中のコンテナの削除

```
# docker rm `docker ps -a -q`
```

# dockerイメージの削除

```
# docker rmi debian/sshd
```

# まとめ

あらかじめ、sshデーモン入りのdocker imageを作成し、ポートフォワーディングしてdockerコンテナを起動すれば外部ホストからdockerコンテナにSSH接続できることを確認した。

# 参考文献

 * https://docs.docker.com/engine/installation/linux/debian/
 * https://hub.docker.com/
 * https://www.conoha.jp/download/books/conoha-book-03-docker.pdf
 * https://gist.github.com/mapk0y/3dd5d270e9c058ef3ab9

