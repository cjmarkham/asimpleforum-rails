class Topic < ApplicationRecord
  belongs_to :author, class_name: :User
  has_one :taggable
  has_many :posts

  before_create :generate_slug

  private

  def generate_slug
    assign_attributes slug: name.gsub(/[^a-zA-Z0-9]/, '-').downcase
  end
end
