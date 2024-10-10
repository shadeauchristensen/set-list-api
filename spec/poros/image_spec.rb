require "rails_helper"

RSpec.describe Image do
  it "can be instantiated with correct properties" do
    input_hash = {
                  "id": 1181789,
                  "url": "https://www.pexels.com/photo/beatles-vinyls-1181789/",
                  "photographer": "Mike",
                  "photographer_url": "https://www.pexels.com/@mike-468229",
                  "photographer_id": 468229,
                  "avg_color": "#89838B",
                  "src": {
                      "original": "https://images.pexels.com/photos/1181789/pexels-photo-1181789.jpeg"
                  },
                  "liked": false,
                  "alt": "Beatles Vinyls"
              }
    
    result_image = Image.new(input_hash)

    expect(result_image).to be_an Image
    expect(result_image.image_url).to eq("https://www.pexels.com/photo/beatles-vinyls-1181789/")
    expect(result_image.photographer).to eq("Mike")
    expect(result_image.photographer_url).to eq("https://www.pexels.com/@mike-468229")
    expect(result_image.alt_text).to eq("Beatles Vinyls")
  end
end