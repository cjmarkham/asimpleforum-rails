class TopicsController < ApplicationController
  def show
    @topic = Topic.find_by_slug params[:id]
  end
end
