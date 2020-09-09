# Description:
#   ランチ検索(外部API連携)

cheerio = require('cheerio-httpcli')

module.exports = (robot) ->

  robot.respond /ランチ/i, (msg) ->
    #リクエストパラメータ
    param = {
      key: '{APIキー}',
      small_area: '{エリアマスタから取得}',
      lunch: 1,
      format: 'json'
    }

    #グルメサーチAPIを叩く
    cheerio.fetch 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1', param, (err, $, res, body) ->
      json = JSON.parse(body)

      #Hubotのmsg.randomで、配列からランダムで要素を返す
      shop = msg.random json.results.shop

      #ランダムで返ってきた店情報を発言
      msg.send "今日のオススメはここ！\n「#{shop.name}」"
      msg.send shop.urls.pc


