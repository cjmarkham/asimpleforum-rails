class TopicChannel < ApplicationCable::Channel
  def subscribed
    topic = Topic.find params[:topic]
    stream_for topic
  end
end
