require 'rails_helper'
require 'pry'

describe "Songs API", type: :request do 
    it "sends a list of songs" do
        Song.create(title: "Wrecking Ball", length: 220, play_count: 3)
        Song.create(title: "Bad Romance", length: 295, play_count: 5)
        Song.create(title: "Shake It Off", length: 219, play_count: 2)

        # execution
        get '/api/v1/songs'

        # assertion
        expect(response).to be_successful

        songs = JSON.parse(response.body, symbolize_names: true)

        expect(songs.count).to eq(3) # <-- expecting to be 3 songs

            # loops through songs
        songs.each do |song| # <--  V 
          expect(song[:id]).to be_an(Integer)
    
          expect(song).to have_key(:title) # V 
          expect(song[:title]).to be_a(String)
    
          expect(song).to have_key(:length) # V 
          expect(song[:length]).to be_a(Integer)
    
          expect(song).to have_key(:play_count) # V
          expect(song[:play_count]).to be_a(Integer)
        end
    end # teardown

    it "can get one song by its id" do
        id = Song.create(title: "Wrecking Ball", length: 220, play_count: 3).id
      
        
        get "/api/v1/songs/#{id}"
        
        song = JSON.parse(response.body, symbolize_names: true)
      
        expect(response).to be_successful
      
        expect(song).to have_key(:id)
        expect(song[:id]).to be_an(Integer)
      
        expect(song).to have_key(:title)
        expect(song[:title]).to be_a(String)
      
        expect(song).to have_key(:length)
        expect(song[:length]).to be_a(Integer)
      
        expect(song).to have_key(:play_count)
        expect(song[:play_count]).to be_a(Integer)
    end
end
# require "pry"; binding.pry

# Three environments in Rails
# 1. Development - db
# 2. Test - db
# 3. Production - db

