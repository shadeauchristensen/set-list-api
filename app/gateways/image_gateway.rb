class ImageGateway
  def self.get_first_image(query_term)
    response = connection.get("/v1/search", { query: query_term })

    json = JSON.parse(response.body, symbolize_names: true)
    Image.new(json[:photos][0])
  end

  private
  
  def self.connection
    Faraday.new(url: "https://api.pexels.com") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.pexels[:key]
    end
  end
end