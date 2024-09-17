require "rails_helper"

RSpec.describe ImageGateway do
  it "should return an Image object when given a query" do
    stubbed_response = File.read("spec/fixtures/pexels_response.json")
    stub_request(:get, "https://api.pexels.com/v1/search?query=The%20Beatles").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=> Rails.application.credentials.pexels[:key],
          'User-Agent'=>'Faraday v2.10.1'
          }).
        to_return(status: 200, body: stubbed_response, headers: {})

    result_image = ImageGateway.get_first_image("The Beatles")

    expect(result_image).to be_an Image
  end
end