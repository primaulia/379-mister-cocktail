class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # WHEN YOU RECEIVE A MESSAGE, BROADCAST TO EVERYONE
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # IF ANYONE LOGS OFF, BROADCAST TO EVERYONE
  end
end
