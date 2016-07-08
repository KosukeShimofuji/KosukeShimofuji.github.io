---
layout: post
title:  "JekyllではじめるBLOG"
date:   2016-07-01 00:00:00 +0900
categories: jekyll 
toc: true
---

## jekyll - 静的サイトジェネレータ

markdown,liquid,sassなどをHTMLにコンバートするためのフレームワーク。ローカルコンピュータ側でコンバート処理は完了するため、PHPやCGIなどの動的にHTMLを生成する必要がない。 Github pageでホストする場合は、jekyllがgithub側で動作しているのでテンプレートだけで生成することができる。
静的サイトジェネレータを利用するレバサーバリソースを消費することなく、セキュリティ的にも好ましいサイトの公開が可能となる。

## Github pageにJekyllで生成したHTMLを公開する

jekyllを利用して初期のHTMLを公開するのは5分程度で実行することができる。

```bash
# 手元にcloneしてくる
$ git clone git@github.com:KosukeShimofuji/KosukeShimofuji.github.io.git
# jekyllをインストールする
$ gem install jekyll
$ gem install jekyll-sitemap
$ gem install jekyll-paginate
$ gem install jekyll-gist
# テンプレートを生成する
$ jekyll new ./KosukeShimofuji.github.io.git
# 現在の状態を組み込みサーバを使って確認する
$ jekyll server -H0.0.0.0
# githubにpushする
$ git add -A && git commit -m "first commit" && git push origin master
```

## 初期のjekyllの構成を抑えておく

jekyllは自分でカスタマイズすることを前提に使うものだと思う。なので初期の構成を抑えて、jekyllの動作を把握するのは重要。

```bash
$ tree KosukeShimofuji.github.io/
KosukeShimofuji.github.io/
├── _config.yml
├── _includes
│   ├── footer.html
│   ├── head.html
│   ├── header.html
│   ├── icon-github.html
│   ├── icon-github.svg
│   ├── icon-twitter.html
│   └── icon-twitter.svg
├── _layouts
│   ├── default.html
│   ├── page.html
│   └── post.html
├── _posts
│   └── 2016-06-30-welcome-to-jekyll.markdown
├── _sass
│   ├── _base.scss
│   ├── _layout.scss
│   └── _syntax-highlighting.scss
├── _site
│   ├── about
│   │   └── index.html
│   ├── css
│   │   └── main.css
│   ├── feed.xml
│   ├── index.html
│   └── jekyll
│       └── update
│           └── 2016
│               └── 06
│                   └── 30
│                       └── welcome-to-jekyll.html
├── about.md
├── css
│   └── main.scss
├── feed.xml
└── index.html

13 directories, 24 files
```

## draftsを追加する

記事の精査をするための下書きの仕組みを導入する

```
$ mkdir _drafts
$ jekyll server -H0.0.0.0 -w -drafts
```

## syntax highlightを変更する 

テーマを[公開](https://github.com/jwarby/jekyll-pygments-themes)されている方がいらっしゃるので使わせてもらう。
[commit](https://github.com/KosukeShimofuji/KosukeShimofuji.github.io/commit/bd84c2ab6bf0fca73a8a695c4d5e4e9ea6431e2a)

## OGPの設定

facebookのシェアボタンなどはOGPの値を読み取って処理を行うため、OGPの設定を行う必要があった。
[commit](https://github.com/KosukeShimofuji/KosukeShimofuji.github.io/commit/f911a168fa4677107c252a9baac354fe5bbec489)

## シェアボタンを追加する

twitter,hatena,facebook,google,pocketからシェアボタンの作り方を閲覧して、[コミット](https://github.com/KosukeShimofuji/KosukeShimofuji.github.io/commit/529f3f24d93b8607d15bb6d8470c65fae6ca266a)を作成した。

## TOCを追加する

```
gem install jekyll-toc
```

[commit](https://github.com/KosukeShimofuji/KosukeShimofuji.github.io/commit/4dcc841aab704b13ca8b4e32384e918b26da1bc3)

github pageではjekyll pluginがsafe
modeになっているため使えないので、ローカルで生成したファイル群をgh-pagesに追加するような運用にする。



## カスタムドメインを設定する。

jekyllとは関係ないが、github pageのCNAMEの設定を行う。

```
kosuke@chaos ~/KosukeShimofuji.github.io $ echo "KosukeShimofuji.jp" > CNAME
```

[ここ](https://help.github.com/articles/troubleshooting-custom-domains/#dns-configuration-errors)の指示通りドメインを取得した企業のコンパネでカスタムドメインのAレコードを以下のIPアドレスに向ける。

```
192.30.252.153
192.30.252.154
```

Aレコードの状態とNSレコードの状態を確認する。

```
kosuke@chaos ~ $ dig kosukeshimofuji.jp @8.8.8.8 a +short
192.30.252.153
192.30.252.154
kosuke@chaos ~ $ dig kosukeshimofuji.jp @8.8.8.8 ns +short
dns01.muumuu-domain.com.
dns02.muumuu-domain.com.
```

上記のようにdnsが設定されれば、カスタムドメインでgithub pageにアクセスすることができる。

## TLSで接続できるようにする

[ここ](http://qiita.com/superbrothers/items/95e5723e9bd320094537)を参考にCloudFlareを利用してCloudFlareとGithub Page間をTLS接続できるようにした。 この時点でのDNSの設定は以下のようになっている。

```
kosuke@chaos ~ $ dig kosukeshimofuji.jp +short a @8.8.8.8
104.31.74.13
104.31.75.13
kosuke@chaos ~ $ dig kosukeshimofuji.jp +short ns @8.8.8.8
sofia.ns.cloudflare.com.
bayan.ns.cloudflare.com.
```

反映に半日程度の時間が必要だった。
Flexible設定はあくまでクライアントからCloudFlare間の通信を暗号化するものなので、CloudFlareは通信を平文で閲覧することができる。
といってもCDNという仕組みは中間者攻撃し放題の仕組みだと思うので、CloudFlareを通してTLSの設定をするというのはCloudFlareに全幅の信頼を置くということだ。

## Page Rules

kosukeshimofuji.jp/*のリクエストを強制的にhttpsに書き換えます。

![page_rule]({{site.baseurl}}/images/2016/07/01/page_rule.png)

## HSTS

kosukeshimofuji.jpのリクエストはHTTPSを使用するように指示します。しかしサブドメインは除外します。

![HSTSk]({{site.baseurl}}/images/2016/07/01/HSTS.png)

## Google Analyticsを設定する

 * Google Tracking codeを有効にする。

[commit](https://github.com/KosukeShimofuji/KosukeShimofuji.github.io/commit/7c816507c7262694619b8c23cbec0e8ce177f590)

[Google Tag Assisant](https://get.google.com/tagassistant/?utm_source=google.com&utm_medium=notif_referral&utm_campaign=TRAFFIC_ANALYSIS_RECOMMENDATION)を使ってTracking Codeが正常に動作するかを確認する。

 * Google Search Consoleに登録する。

[commit](https://github.com/KosukeShimofuji/KosukeShimofuji.github.io/commit/41bfa05cf7d294b1d947895dfa48ab3cd8a9b5e0)

## Disqusを使用する

https://kosukesimofuji-hp.disqus.com/admin/settings/universalcode/


## 参考文献

 * https://jekyllrb-ja.github.io/
 * https://shopify.github.io/liquid/
 * https://ja.wikipedia.org/wiki/Sass
 * http://tokkono.cute.coocan.jp/blog/slow/index.php/programming/github-pages-almost-perfect-guide/
 * http://qiita.com/hurutoriya/items/f8dd9c31d8a1050a4be4
 * https://murashun.jp/blog/20150628-01.html
 * https://help.github.com/articles/using-a-custom-domain-with-github-pages/
 * http://qiita.com/superbrothers/items/95e5723e9bd320094537
 * http://uzulla.hateblo.jp/entry/2015/02/25/033133
 * https://blog.euonymus.info/cloudflare%E3%81%A7ssl%E3%82%92%E5%B0%8E%E5%85%A5%E3%81%99%E3%82%8B%E6%99%82%E3%81%AE%E6%B3%A8%E6%84%8F/
 * https://teamtreehouse.com/library/build-a-blog-with-jekyll-and-github-pages/building-and-customizing-the-blog/comment-threads

