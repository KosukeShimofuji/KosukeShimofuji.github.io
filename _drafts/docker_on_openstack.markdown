---
layout: post
title:  "Docker on OpenStack"
date:   2016-08-09 16:00:00 +0900
categories: development
---

OpenStack上にDockerを起動させて、1つのcompute nodeの上に複数のdockerコンテナを動かして、それぞれとSSH通信がしたい。どうすれば実現できるのかを本エントリで調査する。

# docker-engineのインストール

debianにdocker-engineをインストールする手順は[公式のドキュメント](https://docs.docker.com/engine/installation/linux/debian/)が詳しいので、そちらに譲る。
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
```



# 参考文献

 * https://docs.docker.com/engine/installation/linux/debian/
 * https://hub.docker.com/
 * https://www.conoha.jp/download/books/conoha-book-03-docker.pdf


