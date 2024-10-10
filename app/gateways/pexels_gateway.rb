class PexelsGateway # utility class
  def self.get_image(artist)
    conn = Faraday.new(url: "https://api.pexels.com") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.pexels[:key]
    end

    response = conn.get("/v1/search", { query: artist })
    # OR response = conn.get("/v1/search?query=#{artist})

    json = JSON.parse(response.body, symbolize_names: true)
    json[:photos][0]
  end
end


# Class Method:
## Pros: Could be more flexible with 1-step call,
# don't have to instantiate
## Justification: utility classes are doing something
# not representing something --> class method 

# Instance Method: 
## Pros: maybe need to keep state with authentication?
## Pros: If we know we need to keep state for different URIS