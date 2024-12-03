class Api::V1::PhotographersController < ApplicationController
  def show
    username = params[:username]
    conn = Faraday.new(url: "https://api.unsplash.com") 
    
    response = conn.get("/users/#{username}", { client_id: Rails.application.credentials.unsplash[:key] })

    json = JSON.parse(response.body, symbolize_names: true)

    formatted_response = {
      id: nil,
      type: "photographer",
      attributes: {
        username: json[:name],
        first_name: json[:first_name],
        last_name: json[:last_name],
        twitter_handle: json[:twitter_username]
      }
    }

    render json: { data: formatted_response }
  end
end