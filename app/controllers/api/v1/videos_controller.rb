class Api::V1::VideosController < ApplicationController
  def show
    artist = params[:artist]

    conn = Faraday.new(url: "https://api.pexels.com") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.pexels[:key]
    end

    response = conn.get("/videos/search", { query: artist })
    # OR response = conn.get("/v1/search?query=#{artist})

    json = JSON.parse(response.body, symbolize_names: true)
    first_video = json[:videos][0]

    formatted_json = {
      id: first_video[:id],
      type: "video",
      attributes: {
        video_url: first_video[:url],
        artist: first_video[:user][:name],
        artist_url: first_video[:user][:url],
      }
    }

    render json: { data: formatted_json }
  end
end