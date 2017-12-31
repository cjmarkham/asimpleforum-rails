class Image < ApplicationRecord
  # Imagable will more than likely be a post
  # Optional is true as the post isnt set at time of image upload
  # Once the post is saved, the image is updated with the post ID
  belongs_to :imagable, polymorphic: true, optional: true

  mount_uploader :file, ImageUploader
end
