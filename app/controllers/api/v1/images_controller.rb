class Api::V1::ImagesController < ApplicationController
  def show
    # serializing - DONE
    # connecting to an external API - DONE
    # manipulating data/deserializing - DONE

    json = ImageGateway.get_images_for_artist(params[:artist])

    first_photo = Image.new(json) # deserialization, Image object

    render json: ImageSerializer.format_image(first_photo) # first photo is an Image object, no longer a hash from json
  end
end