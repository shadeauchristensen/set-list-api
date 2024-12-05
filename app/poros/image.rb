class Image
  attr_reader :url,
              :photographer,
              :photographer_username,
              :photographer_url,
              :alt_text

  def initialize(image_json)
    first_photo = image_json[:results][0]

    @url = first_photo[:urls][:raw]
    @photographer = first_photo[:user][:name]
    @photographer_username = first_photo[:user][:username]
    @photographer_url = first_photo[:user][:links][:self]
    @alt_text = first_photo[:alt_description]
  end
end