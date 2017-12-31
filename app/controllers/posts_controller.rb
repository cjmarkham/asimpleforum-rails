class PostsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    post = Post.create create_params.merge(author: current_user)

    if post.valid?
      TopicChannel.broadcast_to post.topic, post.as_json(include: { author: { only: [:username] } })
    else
      render json: post.errors.full_messages
    end
  end

  private

  def create_params
    params.require(:post).permit(
      :topic_id,
      :content,
    )
  end
end
