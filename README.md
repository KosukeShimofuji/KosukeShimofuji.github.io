# KosukeShimofuji.jp

## BLOG環境の構築

 * Rubyとblog環境に関わるruby gemをインストール

```
$ rbenv install 2.3.1
$ rbenv global 2.3.1
$ gem install jekyll
$ gem install jekyll-sitemap
$ gem install jekyll-paginate
$ gem install jekyll-gist
$ gem install jekyll-toc
$ gem install jekyll-amazon
$ gem install jekyll-ditaa
```

 * jekyll-amazonのための環境変数を設定

```
$ cat .envrc
export ECS_ASSOCIATE_TAG=kosukeshimofu-22
export AWS_ACCESS_KEY_ID=AKIAJKVKPSDQH6S2KSMQ
export AWS_SECRET_KEY=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
$ direnv allow
```


## 下書きを作成する

下書きは_drafts以下のファイルを作成することで作成できる。 下書きの内容を確認するには以下のようにローカルサーバを立ち上げて確認する。

```
$ jekyll server -H0.0.0.0 --drafts -w
```

## BLOGを公開する

```
$ sh publish.sh
```

## BLOGのソースコードをgithubにpushする

```
git push origin source
```


