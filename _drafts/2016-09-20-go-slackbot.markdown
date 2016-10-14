---
layout: post
title:  "Go言語で書くSlackbot"
date:   2016-09-20 13:00:00 +0900
categories: development
toc: true
---

[パッチ情報を通知してくれる何かが欲しいから作った](https://kosukeshimofuji.jp/2016/08/01/cve-watch/)で作成した[cve_watch](https://github.com/KosukeShimofuji/cve_watch)をslackbot化するためにGo言語でslackbotを作成する。

# SLACKのBOT用のAPIキーを取得する

[createing a new bot user](https://my.slack.com/services/new/bot)からslack botの設定を行い、API TOKENを取得する。

# Go言語からSlack APIを叩く

```
$ go get github.com/nlopes/slack
```

git@github.com:KosukeShimofuji/slackbot.git

https://hooks.slack.com/services/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

# channelに招待する

```
Event Received: slack.RTMEvent{
    Type: "message",
    Data: &slack.MessageEvent{
        Msg: slack.Msg{
            Type:             "message",
            Channel:          "C2LGELCM8",
            User:             "U03RAJ6BK",
            Text:             "こんにちわ",
            Timestamp:        "1476149519.000109",
            IsStarred:        false,
            PinnedTo:         nil,
            Attachments:      nil,
            Edited:           (*slack.Edited)(nil),
            SubType:          "",
            Hidden:           false,
            DeletedTimestamp: "",
            EventTimestamp:   "",
            BotID:            "",
            Username:         "",
            Icons:            (*slack.Icon)(nil),
            Inviter:          "",
            Topic:            "",
            Purpose:          "",
            Name:             "",
            OldName:          "",
            Members:          nil,
            File:             (*slack.File)(nil),
            Upload:           false,
            Comment:          (*slack.Comment)(nil),
            ItemType:         "",
            ReplyTo:          0,
            Team:             "T03GLB4LV",
            Reactions:        nil,
        },
        SubMessage: (*slack.Msg)(nil),
    },
}
```

# 参考文献

 * https://api.slack.com/community
 * https://github.com/nlopes/slack
 * https://api.slack.com/bot-users
 * https://api.slack.com/rtm
 * https://api.slack.com/events
 * http://deeeet.com/writing/2016/07/22/context/
 * http://kyokomi.hatenablog.com/entry/2015/06/21/213610
 * https://api.slack.com/bot-users
 * https://github.com/nlopes/slack
 * http://golang.jp/
 * http://qiita.com/tutuming/items/c0ffdd28001ee0e9320d
 * https://git.pepabo.com/dojineko/izumino-checker
 * https://github.com/haowang1013/slack-bot/blob/f8de0322f10502a654d2838e647a60ea7069fab0/main.go 
 * https://github.com/puppychen/gobot
 * https://gowalker.org/github.com/nlopes/slack


