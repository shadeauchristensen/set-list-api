class Api::V1::ImagesController < ApplicationController
  def show
    artist = params[:artist]
    first_photo_response = PexelsGateway.get_image(artist) # hash
    first_photo = Image.new(first_photo_response) # Image
    render json: ImageSerializer.format_images(first_photo)
  end
end