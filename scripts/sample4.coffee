# Description:
#   定時退社のお知らせ

cron    = require("node-cron")
cheerio = require("cheerio-httpcli")

module.exports = (robot) ->
  # トークン取得
  token   = robot.adapter.options.token
  channel = "{チャンネルID}" 

  # 指定チャンネル発言
  send = (channel, msg) ->
    robot.send {room: channel}, msg

  # アクティブメンバーへメッセージ送信
  sendActiveUserMessage = (sendMsg) ->
    request = {
      token: token,
      channel: channel,
    }

    # チャンネルメンバー取得
    cheerio.fetch "https://slack.com/api/conversations.members", request, (err, $, result, body) ->
      resObj = JSON.parse(body)

      channelMembers = []

      for id in resObj.members
        # hubotのIDも取得してしまうため除外する
        if id == "{hubotのUID}"
          continue

        channelMembers.push id

      # メンバーのアクティブ状態取得
      activeMembers = []
      for id in channelMembers
        request = {
          token: token,
          user: id,
        }

        result = cheerio.fetchSync "https://slack.com/api/users.getPresence", request
        resObj = JSON.parse(result.body)

        # アクティブになっているメンバーを取得
        if resObj.presence == "active"
          activeMembers.push id

      # メンバー情報取得
      mensions = []
      for id in activeMembers
        request = {
          token: token,
          user: id,
        }

        result = cheerio.fetchSync "https://slack.com/api/users.info", request
        resObj = JSON.parse(result.body)
        mensions.push resObj.user.name

      # メンション用の名前を取得
      if mensions.length > 0
        message = ""
        for name in mensions
          message += "@#{name}\n"

        message += sendMsg
        send channel, message

  # 指定時間になったら通知させる
  cron.schedule '0 21 4 * * 1-5', () ->
    sendActiveUserMessage("定時過ぎてるよ〜\n早く帰ろう！")

