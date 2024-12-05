class ImageSerializer
  def self.format_image(image)
    {
      data: {
        id: nil,
        type: "image",
        attributes: {
          image_url: image.url,
          photographer: image.photographer,
          photographer_username: image.photographer_username,
          photographer_url: image.photographer_url,
          alt_text: image.alt_text
        }
      }
    }
  end
end