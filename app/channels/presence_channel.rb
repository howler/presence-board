class PresenceChannel < ActionCable::Channel::Base
  def subscribed
    stream_from "presence"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
