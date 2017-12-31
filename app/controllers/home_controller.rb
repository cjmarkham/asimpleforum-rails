class HomeController < ApplicationController
  def index
    @topics = Topic.includes(:author).includes(:taggable).all
  end
end
