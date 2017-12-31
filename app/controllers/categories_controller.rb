class CategoriesController < ApplicationController
  def index
    @topics = Topic.all.order(updated_at: :desc)
  end

  def show
    @topics = Topic.in_category(params[:id]).order(updated_at: :desc)
    render :index
  end
end
