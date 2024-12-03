require "rails_helper"

RSpec.describe "Images Endpoint" do
  describe "happy path" do
    it "can retrieve an image for a specific artist specific artist" do
      stubbed_response = File.read("spec/fixtures/unsplash_photo_search.json")

      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{Rails.application.credentials.unsplash[:key]}&query=The%20Beatles").
        to_return(status: 200, body: stubbed_response, headers: {})

      get "/api/v1/images?artist=The%20Beatles"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq("image")
      expect(json[:data][:attributes]).to have_key(:image_url)
      expect(json[:data][:attributes][:image_url]).to eq("https://images.unsplash.com/photo-1585366119957-e9730b6d0f60?ixid=M3w2NDYyMTJ8MHwxfHNlYXJjaHwxfHxUaGUlMjBCZWF0bGVzfGVufDB8fHx8MTczMzI0MjU0OXww&ixlib=rb-4.0.3")
      expect(json[:data][:attributes]).to have_key(:photographer)
      expect(json[:data][:attributes]).to have_key(:photographer_url)
      expect(json[:data][:attributes]).to have_key(:alt_text)
    end
  end
end