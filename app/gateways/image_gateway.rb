class ImageGateway
  # responsibility: make connection and API call to external system
  def self.conn 
    Faraday.new(url: "https://api.unsplash.com") 
  end

  def self.get_images_for_artist(artist)
    response = conn.get("/search/photos", { query: artist, client_id: Rails.application.credentials.unsplash[:key] })

    JSON.parse(response.body, symbolize_names: true)
  end
end