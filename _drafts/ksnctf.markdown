---
layout: post
title:  "Ksnctf備忘録"
date:   2016-07-06 18:00:00 +0900
categories: CTF
---

## [2] - [Easy Cipher](http://ksnctf.sweetduet.info/problem/2)

```
EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur
yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur
Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg
na haqrefpber vzzrqvngryl nsgre SYNT.
```

[rot.py](https://github.com/KosukeShimofuji/CTF/blob/master/bin/rot.py)を作って解いた。

```
kosuke@chaos ~/CTF $ python bin/rot.py 13 easycipher.txt
ROT XIII is a simple letter substitution cipher that replaces a letter with th
letter XIII letters after it in the alphabet. ROT XIII is an example of the
Caesar cipher, developed in ancient Rome. Flag is FLAGSwzgxBJSAMqwxxAU. Insert
an underscore immediately after FLAG.
```

## [3] - [Crawling Chaos](http://ksnctf.sweetduet.info/problem/3)

[難読化されたスクリプト](https://github.com/KosukeShimofuji/CTF/blob/master/ksnctf/q3/unya.html#L12)が使用されており、難読化を解くことでフラグを得ることができる。
這いよれ、うー、にゃー、javascriptなどのキーワードでググると[unyaencode](http://sanya.sweetduet.info/unyaencode/)でエンコードされていることがわかる。
unyaencodeの記事からここから記号プログラミングの仕組みを理解することができる。

 * http://utf-8.jp/public/aaencode.html
 * http://utf-8.jp/public/jjencode.html
 * http://d.hatena.ne.jp/kusano_k/20120421/1335006525
 * http://perl-users.jp/articles/advent-calendar/2010/sym/3
 * http://perl-users.jp/articles/advent-calendar/2010/sym/15

Chromeのdebuggerで難読化されたスクリプトをpretty printで整形してbreak
point入れてstop overしていくと、難読化されたスクリプトを得ることができる。

![q03]({{site.baseurl}}/images/2016/07/07/q03.gif)

```javascript
(function() {
    $(function() {
        $("form").submit(function() {
            var t = $('input[type="text"]').val();
            var p = Array(70, 152, 195, 284, 475, 612, 791, 896, 810, 850, 737, 1332, 1469, 1120, 1470, 832, 1785, 2196, 1520, 1480, 1449);
            var f = false;
            if (p.length == t.length) {
                f = true;
                for (var i = 0; i < p.length; i++)
                    if (t.charCodeAt(i) * (i + 1) != p[i])
                        f = false;
                if (f)
                    alert("(」・ω・)」うー!(/・ω・)/にゃー!");
            }
            if (!f)
                alert("No");
            return false;
        });
    });
}
)
```

上記スクリプトを見て、FLAGを得る[スクリプト](https://github.com/KosukeShimofuji/CTF/blob/master/ksnctf/q3/get_flag.py)を作成する。

## [4] - [Villager A](http://ksnctf.sweetduet.info/problem/4)


