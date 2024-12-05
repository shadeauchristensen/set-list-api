require "rails_helper"

RSpec.describe Image do
  it "can extract data from json hash and populate attributes" do
    # input - JSON hash
    # output - Image object

    sample_input_raw = File.read("spec/fixtures/unsplash_photo_search.json")
    sample_input = JSON.parse(sample_input_raw, symbolize_names: true)
    result_image = Image.new(sample_input)

    expect(result_image.url).to eq("https://images.unsplash.com/photo-1585366119957-e9730b6d0f60?ixid=M3w2NDYyMTJ8MHwxfHNlYXJjaHwxfHxUaGUlMjBCZWF0bGVzfGVufDB8fHx8MTczMzI0MjU0OXww&ixlib=rb-4.0.3")
    expect(result_image.photographer).to eq("Daniel K Cheung")
    expect(result_image.photographer_username).to eq("danielkcheung")
    expect(result_image.photographer_url).to eq("https://api.unsplash.com/users/danielkcheung")
    expect(result_image.alt_text).to eq("white and black lego toy")
  end
end