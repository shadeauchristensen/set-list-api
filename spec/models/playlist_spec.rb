require "rails_helper"

RSpec.describe Playlist, type: :model do
  it { should have_many :playlist_songs }
  it { should have_many(:songs).through(:playlist_songs) }
  describe "class_methods" do
    describe "longest_length" do
      xit "returns the playlist with the longest total length of all songs" do
        load_test_data
        
        expect(Playlist.longest_length).to eq(@chill_evening)
      end
    end
  end
end