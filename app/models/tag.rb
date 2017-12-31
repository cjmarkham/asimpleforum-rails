class Tag < ApplicationRecord
  has_many :taggable

  before_validation :generate_slug

  private

  def generate_slug
    slug = name.downcase.gsub(/[^a-zA-Z0-9]/, '-')
    assign_attributes slug: slug
  end
end
