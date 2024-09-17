class Image
  attr_reader :url,
              :photographer,
              :photographer_url,
              :alt_text

  def initialize(data)
    @url = data[:url]
    @photographer = data[:photographer]
    @photographer_url = data[:photographer_url]
    @alt_text = data[:alt]
  end
end