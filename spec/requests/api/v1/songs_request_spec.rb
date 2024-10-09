require 'rails_helper'

describe "Songs API" do
  describe "as a visitor, require user registration for" do
    before (:each) do
      Song.create(title: "Wrecking Ball", length: 220, play_count: 3)
      Song.create(title: "Bad Romance", length: 295, play_count: 5)
      Song.create(title: "Shake It Off", length: 219, play_count: 2)
    end

    it "songs index" do
      get '/api/v1/songs'

      body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to_not be_successful
      expect(body[:error]).to eq("Unauthorized, please register as a user")
    end

    it "songs show" do
      get '/api/v1/songs/1'

      body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to_not be_successful
      expect(body[:error]).to eq("Unauthorized, please register as a user")
    end

    it "songs create" do
      song_params = {
        title: "Wrecking Ball",
        length: 220,
        play_count: 3
      }
      headers = { "CONTENT_TYPE" => "application/json" }

      post "/api/v1/songs", headers: headers, params: JSON.generate(song: song_params)

      body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to_not be_successful
      expect(body[:error]).to eq("Unauthorized, please register as a user")
    end

    it "songs update" do
      id = Song.create(title: "Shake It Off", length: 219, play_count: 2).id
      previous_name = Song.last.title
      song_params = { title: "Shake It Off (Taylor's Version)" }
      headers = {"CONTENT_TYPE" => "application/json"}
  
      patch "/api/v1/songs/#{id}", headers: headers, params: JSON.generate({song: song_params})
      body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to_not be_successful
      expect(body[:error]).to eq("Unauthorized, please register as a user")
    end

    it "songs delete" do
      song = Song.create(title: "Wrecking Ball", length: 220, play_count: 3)

      expect(Song.count).to eq(4)
  
      delete "/api/v1/songs/#{song.id}"

      body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to_not be_successful
      expect(body[:error]).to eq("Unauthorized, please register as a user")
    end

  end

  describe "As a registered user with default role" do
    before(:each) do
      Song.create(title: "Wrecking Ball", length: 220, play_count: 3)
      Song.create(title: "Bad Romance", length: 295, play_count: 5)
      Song.create(title: "Shake It Off", length: 219, play_count: 2)
      @default_user = User.create!(email: "default@example.com", password: "test123")
    end

    it "sends a list of songs" do
      headers = { "Authorization" => @default_user.api_token }
      get '/api/v1/songs', headers: headers

      expect(response).to be_successful
  
      songs = JSON.parse(response.body, symbolize_names: true)
  
      expect(songs.count).to eq(3)
  
      songs.each do |song|
        expect(song[:id]).to be_an(Integer)
        expect(song[:title]).to be_a(String)
        expect(song[:length]).to be_a(Integer)
        expect(song[:play_count]).to be_a(Integer)
      end
    end

    it "sends a single song" do
      db_song = Song.first
      headers = { "Authorization" => @default_user.api_token }
      get "/api/v1/songs/#{db_song.id}", headers: headers
      
      response_song = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
  
      expect(response_song[:id]).to eq(db_song.id)
      expect(response_song[:title]).to eq(db_song.title)
      expect(response_song[:length]).to eq(db_song.length)
      expect(response_song[:play_count]).to eq(db_song.play_count)
    end

    it "does not allow new song creation" do
      song_params = {
        title: "Wrecking Ball",
        length: 220,
        play_count: 3
      }
      headers = { "Authorization" => @default_user.api_token, "CONTENT_TYPE" => "application/json" }

      post "/api/v1/songs", headers: headers, params: JSON.generate(song: song_params)

      expect(response.status).to eq(405)
      # expect a Method Not Allowed status
    end
  end

  describe "As a registered user with default role" do
    before(:each) do
      Song.create(title: "Wrecking Ball", length: 220, play_count: 3)
      Song.create(title: "Bad Romance", length: 295, play_count: 5)
      Song.create(title: "Shake It Off", length: 219, play_count: 2)
      @admin_user = User.create!(email: "default@example.com", password: "test123", role: 1)
    end

    it "allows new song creation" do
      song_params = {
        title: "Wrecking Ball",
        length: 220,
        play_count: 3
      }
      headers = { "Authorization" => @admin_user.api_token, "CONTENT_TYPE" => "application/json" }

      post "/api/v1/songs", headers: headers, params: JSON.generate(song: song_params)

      created_song = Song.last

      expect(response).to be_successful
      expect(created_song.title).to eq(song_params[:title])
      expect(created_song.length).to eq(song_params[:length])
      expect(created_song.play_count).to eq(song_params[:play_count])
    end
  end
end
