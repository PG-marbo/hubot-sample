# Description:
#   Hubotからリアクションさせる

cheerio = require('cheerio-httpcli')

module.exports = (robot) ->

  #**********************************
  # ぴょんぴょんに反応させる
  #**********************************
  robot.hear /ぴょんぴょん/i, (res) ->

    # リクエスト作成
    request = {
      token: robot.adapter.options.token,
      name: "rabbit2",
      channel: res.message.room,
      timestamp: res.message.id,
    }

    # cheerioでリクエスト
    cheerio.fetchSync "https://slack.com/api/reactions.add", request
