require "rails_helper"

RSpec.describe "Images Endpoint" do
  describe "happy path" do
    it "can retrieve an image for a specific artist specific artist" do
      # This line allows us to test the real connection to the Pexels API instead of stubbing it
      WebMock.allow_net_connect!
      
      get "/api/v1/images?artist=The%20Beatles"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq("image")
      expect(json[:data][:attributes]).to have_key(:image_url)
      expect(json[:data][:attributes]).to have_key(:photographer)
      expect(json[:data][:attributes]).to have_key(:photographer_url)
      expect(json[:data][:attributes]).to have_key(:alt_text)
    end
  end
end