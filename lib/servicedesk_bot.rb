require 'telegram/bot'

token = '569477629:AAFBzThmvlkBX0vlZylPhcf1H5Mp8GJzlIQ'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "https://storybird.s3.amazonaws.com/artwork/andymcnally/full/happy-bot.jpeg I am the ServiceDesk bot, nice to see you. My commands are /users /tickets /tickets_count /github /good_bye")
    when '/users'
      bot.api.send_message(chat_id: message.chat.id, text: "#{User.all.map{ |u| u.username}.join(", ")}")
    when '/tickets'
      bot.api.send_message(chat_id: message.chat.id, text: "#{Ticket.all.map{ |t| t.title}.join(", ")}")
    when '/tickets_count'
      bot.api.send_message(chat_id: message.chat.id, text: "For now I have #{Ticket.all.count} tickets")
    when '/github'
      bot.api.send_message(chat_id: message.chat.id, text: "https://github.com/alexgonor/ServiceDesk")
    when '/good_bye'
      bot.api.send_message(chat_id: message.chat.id, text: "I hope to see you soon.. https://img00.deviantart.net/43d5/i/2016/063/8/4/detective_sad_robot_by_spikesthecat-d9tv8se.png")
    end
  end
end
