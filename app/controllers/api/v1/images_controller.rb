class Api::V1::ImagesController < ApplicationController
  def show
    artist = params[:artist]

    first_photo = ImageGateway.get_first_image(artist)

    render json: ImageSerializer.format_image_response(first_photo)
  end
end