require 'rails_helper'

describe "Songs API" do
  describe "as a visitor, require user registration" do
    before (:each) do
      Song.create(title: "Wrecking Ball", length: 220, play_count: 3)
      Song.create(title: "Bad Romance", length: 295, play_count: 5)
      Song.create(title: "Shake It Off", length: 219, play_count: 2)
    end

    it "songs index" do
      get '/api/v1/songs'

      expect(response).to be_successful
    end

    it "songs show" do
    end

    it "songs create" do
    end

    it "songs update" do
    end

    it "songs delete" do
    end

  end

  it "sends a list of songs" do
    Song.create(title: "Wrecking Ball", length: 220, play_count: 3)
    Song.create(title: "Bad Romance", length: 295, play_count: 5)
    Song.create(title: "Shake It Off", length: 219, play_count: 2)

    get '/api/v1/songs'

    expect(response).to be_successful

    songs = JSON.parse(response.body, symbolize_names: true)

    expect(songs.count).to eq(3)

    songs.each do |song|
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

  it "can create a new song" do
    song_params = {
                    title: "Wrecking Ball",
                    length: 220,
                    play_count: 3
    }
    headers = { "CONTENT_TYPE" => "application/json" }
    # We include this header to make sure that these params are passed as JSON rather than as plain text

    post "/api/v1/songs", headers: headers, params: JSON.generate(song: song_params)
    created_song = Song.last

    expect(response).to be_successful
    expect(created_song.title).to eq(song_params[:title])
    expect(created_song.length).to eq(song_params[:length])
    expect(created_song.play_count).to eq(song_params[:play_count])
  end

  it "can update an existing song" do
    id = Song.create(title: "Shake It Off", length: 219, play_count: 2).id
    previous_name = Song.last.title
    song_params = { title: "Shake It Off (Taylor's Version)" }
    headers = {"CONTENT_TYPE" => "application/json"}
    # We include this header to make sure that these params are passed as JSON rather than as plain text

    patch "/api/v1/songs/#{id}", headers: headers, params: JSON.generate({song: song_params})
    song = Song.find_by(id: id)

    expect(response).to be_successful
    expect(song.title).to_not eq(previous_name)
    expect(song.title).to eq("Shake It Off (Taylor's Version)")
  end

  it "can destroy an song" do
    song = Song.create(title: "Wrecking Ball", length: 220, play_count: 3)

    expect(Song.count).to eq(1)

    delete "/api/v1/songs/#{song.id}"

    expect(response).to be_successful
    expect(Song.count).to eq(0)
    expect{ Song.find(song.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end