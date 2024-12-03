class Api::V1::ImagesController < ApplicationController
  def show
    artist = params[:artist]
    conn = Faraday.new(url: "https://api.unsplash.com") 
    # Faraday.get()
    
    response = conn.get("/search/photos", { query: artist, client_id: Rails.application.credentials.unsplash[:key] })
    require 'pry'; binding.pry
    json = JSON.parse(response.body, symbolize_names: true)
    first_photo = json[:results][0]

    formatted_json = {
      id: nil,
      type: "image",
      attributes: {
        image_url: first_photo[:urls][:raw],
        photographer: first_photo[:user][:name],
        photographer_username: first_photo[:user][:username],
        photographer_url: first_photo[:user][:links][:self],
        alt_text: first_photo[:alt_description]
      }
    }

    render json: { data: formatted_json }
  end
end