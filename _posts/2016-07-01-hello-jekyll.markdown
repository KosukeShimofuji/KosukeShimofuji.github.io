---
layout: post
title:  "JekyllではじめるBLOG"
date:   2016-07-01 00:00:00 +0900
categories: jekyll 
---

## jekyll - 静的サイトジェネレータ

markdown,liquid,sassなどをHTMLにコンバートするためのフレームワークとみなすことができると思う。
ローカルコンピュータ側でコンバート処理は完了するため、PHPやCGIなどの動的にHTMLを生成する必要がない。
Github pageでホストする場合は、jekyllがgithub側で動作しているのでテンプレートだけで生成することができる。
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

## OGPの設定

facebookのシェアボタンなどはOGPの値を読み取って処理を行うため、OGPの設定を行う必要があった。
[この](https://gist.github.com/KosukeShimofuji/33a65a605791d358383f7b7d3faf0099)ようにliquidの制御構造を使ってページによってOGPを設定するたたき台を作った。

## シェアボタンを追加する

twitter,hatena,facebook,google,pocketからシェアボタンの作り方を閲覧して、[この](https://gist.github.com/KosukeShimofuji/413168a6a4a49eeccbd36368dceec450)ようにスクリプト部をheadタグに入れた。ただしpocketだけはheadに入れてもだめだったのでshareボタンを出力するタグの直後にscriptタグを配置するようにした。

## 参考文献

 * https://jekyllrb-ja.github.io/
 * https://shopify.github.io/liquid/
 * https://ja.wikipedia.org/wiki/Sass
 * http://tokkono.cute.coocan.jp/blog/slow/index.php/programming/github-pages-almost-perfect-guide/
 * http://qiita.com/hurutoriya/items/f8dd9c31d8a1050a4be4
 * https://murashun.jp/blog/20150628-01.html


