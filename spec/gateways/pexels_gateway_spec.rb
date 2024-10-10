require "rails_helper"

RSpec.describe PexelsGateway do
  it "should return an image related to artist when given artist query" do
    # input -> artist
    artist = "Beyonce"

    # ACT
    result = PexelsGateway.get_image(artist)

    # option for expecting output to be deserialized into Image
    # expect(result.attributes).to include(:url)
    # expect(result).to be_a Image
    # expect(result.image_url).to be_a String
    # expect(result.photographer).to be_a String
    # expect(result.photographer_url).to be_a String
    # expect(result.alt_text).to be_a String

    # output is a hash
    expect(result[:url]).to be_a String
    expect(result[:photographer]).to be_a String
    expect(result[:photographer_url]).to be_a String
    expect(result[:alt]).to be_a String
  end
end