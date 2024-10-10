class Image
  attr_reader :image_url,
              :photographer,
              :photographer_url,
              :alt_text

  def initialize(photo_data)
    @image_url = photo_data[:url]
    @photographer = photo_data[:photographer]
    @photographer_url = photo_data[:photographer_url]
    @alt_text = photo_data[:alt]
    @footer_text = format_footer
  end

  def format_footer
    "#{photographer} wants you to follow him on Instagram!"
  end

  #business logic methods related to Images
end