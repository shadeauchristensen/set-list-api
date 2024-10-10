class ImageSerializer
  def self.format_images(image)
    {
      data:     
        {
          id: nil,
          type: "image",
          attributes: {
            image_url: image.image_url,
            photographer: image.photographer,
            photographer_url: image.photographer_url,
            alt_text: image.alt_text
          }
        }
    }

  end
end