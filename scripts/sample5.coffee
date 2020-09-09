# Description:
#   スクレイピングによる情報取得

cheerio = require("cheerio-httpcli")

module.exports = (robot) ->

  # アニメという単語に反応して、外部サイトからアニメ情報を取得&発言させる
  robot.hear /アニメ/i, (msg) ->
    cheerio.fetch 'スクレイピングするサイト', (err, $, res, body) ->
      msg = 'オススメのアニメはこれだ！\n'

      # cheerioではjQueryのように$指定で、DOM要素を取得することができる
      for child in $('#id').children()
          msg += child.name

      robot.send {room:  "{チャンネル名}" }, msg
