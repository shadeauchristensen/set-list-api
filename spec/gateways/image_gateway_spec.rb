require "rails_helper"

RSpec.describe ImageGateway do
  describe "get images for an artist" do
    it "calls Unsplash API with artist query and returns json response" do
      # input: artist string
      # output: ruby hash from the json (parsed)

      response_hash = ImageGateway.get_images_for_artist("Beyonce")

      expect(response_hash).to be_a Hash
      expect(response_hash).to have_key(:results)
      expect(response_hash).to_not have_key(:errors)
      expect(response_hash[:results]).to be_an Array
      first_photo = response_hash[:results][0]
      expect(first_photo[:urls]).to have_key(:raw) 
      expect(first_photo[:user]).to have_key(:name) 
      expect(first_photo[:user]).to have_key(:username) 
      expect(first_photo[:user]).to have_key(:links) 
      expect(first_photo).to have_key(:alt_description) 
    end
  end
end