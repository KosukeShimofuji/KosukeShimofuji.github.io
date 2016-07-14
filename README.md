# KosukeShimofuji.jp

## BLOG環境の構築

```
$ rbenv install 2.3.1
$ rbenv global 2.3.1
$ gem install jekyll
$ gem install jekyll-sitemap
$ gem install jekyll-paginate
$ gem install jekyll-gist
$ gem install jekyll-toc
```

## 下書きを作成する

下書きは_drafts以下のファイルを作成することで作成できます。
下書きの内容を確認するには以下のようにローカルサーバを立ち上げて確認します。

```
$ jekyll server -H0.0.0.0 --drafts -w
```

## BLOGを公開する

```
$ sh publish.sh
```

