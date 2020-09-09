# Description:
#   unixtime <=> 年月日時相互変換

moment = require("moment")

module.exports = (robot) ->

  #***********************************
  # unixtime→年月日時秒変換
  #**********************************

  # unixtimeのフォーマットに反応させる
  robot.hear /^[0-9]{10}$/i, (res) ->

    # unixtime取得
    unixTime = res.match[0]

    # 送信
    res.send moment.unix(unixTime).format("YYYY-MM-DD HH:mm:ss")

  #***********************************
  # 年月日時秒→unixtime変換
  #**********************************

  # 年月日時秒のフォーマットに反応させる
  robot.hear /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}(\s-\s[0-9]{4}\/[0-9]{2}\/[0-9]{2}|\s[0-9]{2}:[0-9]{2}:[0-9]{2})?$/i, (res) ->

    # 日時取得
    date = res.match[0]

    # 送信
    res.send moment(date).format("X")
