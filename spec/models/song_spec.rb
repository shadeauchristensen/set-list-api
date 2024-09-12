require "rails_helper"

RSpec.describe Song, type: :model do
  it { should belong_to :artist }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:length) }
  it { should validate_presence_of(:play_count) }
  it { should validate_numericality_of(:length) }
  it { should validate_numericality_of(:play_count) }

  describe "instance methods" do
    before :each do
      @prince = Artist.create!(name: "Prince")
      @purple = Song.create!(title: "Purple Rain", length: 845, play_count: 8599, artist_id: @prince.id)
      @beret = Song.create!(title: "Raspberry Beret", length: 664, play_count: 99, artist_id: @prince.id)
      @other_song = Song.create!(title: "Another Prince Song", length: 1, play_count: 99, artist_id: @prince.id)
    end
  end
end