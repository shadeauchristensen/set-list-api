require "rails_helper"

RSpec.describe "Photographers Endpoint" do
  describe "happy path" do
    it "can retrieve photographer details", :vcr do
      get "/api/v1/photographers?username=danielkcheung"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq("photographer")
      expect(json[:data][:attributes]).to have_key(:username)
      expect(json[:data][:attributes]).to have_key(:first_name)
      expect(json[:data][:attributes]).to have_key(:last_name)
      expect(json[:data][:attributes]).to have_key(:twitter_handle)
    end
  end
end