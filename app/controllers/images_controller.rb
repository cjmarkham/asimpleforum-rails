class ImagesController < ApplicationController
  protect_from_forgery except: :create

  def create
    image = Image.create(
      file: create_params[:file],
    )

    if image.valid?
      render json: image.to_json, status: 201
    else
      render json: { errors: image.errors }.to_json
    end
  end

  private

  def create_params
    params.require(:image).permit(
      :file,
    )
  end
end
