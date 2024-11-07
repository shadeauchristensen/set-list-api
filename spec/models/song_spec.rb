require "rails_helper"

RSpec.describe Song, type: :model do
  it {should belong_to :artist}
  it { should have_many :playlist_songs }
  it { should have_many(:playlists).through(:playlist_songs) }

  describe "instance methods" do
    before :each do
      @prince = Artist.create!(name: "Prince")
      @purple = Song.create!(title: "Purple Rain", length: 845, play_count: 8599, artist_id: @prince.id)
      @beret = Song.create!(title: "Raspberry Beret", length: 664, play_count: 99, artist_id: @prince.id)
      @other_song = Song.create!(title: "Another Prince Song", length: 1, play_count: 99, artist_id: @prince.id)
    end
  end

  describe "class methods" do
    describe ".on_all_playlists" do
      xit "returns a unique list of songs on all playlists" do
        load_test_data
        # call sort on both expected and actual values because we don"t care about order
        expect(Song.on_all_playlists.sort).to eq([@beret, @bad_guy, @purple_rain, @change, @talk, @vagabond].sort)
      end
    end
  end
end