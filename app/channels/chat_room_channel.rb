class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_msg(data)
    ActionCable.server.broadcast "chat_room", message:data['message'], user: current_user
    Message.create! body: data['message'], user: current_user
  end
end
