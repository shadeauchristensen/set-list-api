require "rails_helper"

RSpec.describe Image do
  it "should instantiate with correct attribute values" do
    first_photo = JSON.parse(File.read("spec/fixtures/first_photo.json"), symbolize_names: true)

    image = Image.new(first_photo)

    expect(image.url).to eq("https://www.pexels.com/photo/beatles-vinyls-1181789/")
    expect(image.photographer).to eq("Mike")
    expect(image.photographer_url).to eq("https://www.pexels.com/@mike-468229")
    expect(image.alt_text).to eq("Beatles Vinyls")
  end
end