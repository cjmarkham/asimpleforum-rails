class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :author, class_name: :User

  after_create :update_topic_replies

  private

  def update_topic_replies
    topic.increment! :replies
  end
end
