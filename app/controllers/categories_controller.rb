class CategoriesController < ApplicationController
  def index
    @topics = Topic.includes(:author).includes(:taggable).all.order(updated_at: :desc)
  end
end
