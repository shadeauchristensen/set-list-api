require "rails_helper"

RSpec.describe "Videos Endpoint" do
  describe "happy path" do
    it "can retrieve a video for a specific artist", :vcr do
      # This test uses VCR. Notice the :vcr flag in the test line above
      # A fixture has been generated with the description of this test as a file name

      get "/api/v1/videos?artist=The%20Beatles"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to be_a Integer
      expect(json[:data][:type]).to eq("video")
      expect(json[:data][:attributes]).to have_key(:video_url)
      expect(json[:data][:attributes]).to have_key(:artist)
      expect(json[:data][:attributes]).to have_key(:artist_url)
    end
  end
end