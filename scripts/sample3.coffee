# Description:
#   Hubotからリアクションさせる

cron = require('node-cron')

module.exports = (robot) ->

  # cron形式で指定時間をセット
  cron.schedule('0 0 10 * * *', () ->

    # 指定のチャンネルへ発言
    robot.send {room: '#random'}, '今日も１日頑張るぞい'
  )
