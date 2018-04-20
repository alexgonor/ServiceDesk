require 'telegram/bot'

class TelegramBotJob

  TOKEN = ENV['TELEGRAM_BOT_TOKEN']
  CHANNEL = ENV['TELEGRAM_BOT_CHANNEL']

  def perform_async_create(id, title, ticket_author)
    puts TOKEN
    puts CHANNEL

    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.api.send_message(chat_id: CHANNEL, text: "Ticket ID #{id} with title: #{title} was created by #{ticket_author}")
    end
  end

  def perform_async_update(id, title, ticket_author)
    puts TOKEN
    puts CHANNEL

    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.api.send_message(chat_id: CHANNEL, text: "Ticket ID #{id} with title: #{title} was updated by #{ticket_author}")
    end
  end

  def perform_async_destroy(id, title, ticket_author)
    puts TOKEN
    puts CHANNEL

    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.api.send_message(chat_id: CHANNEL, text: "Ticket ID #{id} with title: #{title} was destroyed by #{ticket_author}")
    end
  end
end
