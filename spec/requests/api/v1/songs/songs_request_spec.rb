require "rails_helper"

RSpec.describe "Songs endpoints" do
  before :each do
    @prince = Artist.create!(name: "Prince")
  end

  it "can send a list of songs" do
    @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
    @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)
    @prince.songs.create!(title: 'Kiss', length: 2301, play_count: 2300000)

    get api_v1_songs_path

    expect(response).to be_successful

    songs = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(songs.count).to eq(3)

    songs.each do |song|

      expect(song).to have_key(:id)
      expect(song[:id]).to be_an(String)

      expect(song[:attributes]).to have_key(:title)
      expect(song[:attributes][:title]).to be_a(String)

      expect(song[:attributes]).to have_key(:length)
      expect(song[:attributes][:length]).to be_an(Integer)

      expect(song[:attributes]).to have_key(:play_count)
      expect(song[:attributes][:play_count]).to be_an(Integer)
    end
  end

  it "can get return about one song" do
    song_1 = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)

    get api_v1_song_path(song_1)

    expect(response).to be_successful

    song_response = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(song_response).to have_key(:id)
    expect(song_response[:id]).to eq(song_1.id.to_s)

    expect(song_response[:attributes]).to have_key(:title)
    expect(song_response[:attributes][:title]).to eq(song_1.title)

    expect(song_response[:attributes]).to have_key(:length)
    expect(song_response[:attributes][:length]).to eq(song_1.length)

    expect(song_response[:attributes]).to have_key(:play_count)
    expect(song_response[:attributes][:play_count]).to eq(song_1.play_count)
  end

  it "can create a new song" do
    song_params = ({
      title: "Get Up Offa That Thing",
      length: 4567,
      play_count: 456445,
      artist_id: @prince.id
    })

    post api_v1_songs_path, params: song_params, as: :json
    created_song = Song.last

    expect(response).to be_successful
    expect(response.code).to eq("201")

    expect(created_song.title).to eq(song_params[:title])
    expect(created_song.length).to eq(song_params[:length])
    expect(created_song.play_count).to eq(song_params[:play_count])
    expect(created_song.artist).to eq(@prince)
  end

  it "can update an existing song" do
    song_1 = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)

    song_update_params = {
      length: 323
    }

    patch api_v1_song_path(song_1), params: song_update_params, as: :json

    updated_song = Song.find(song_1.id)

    expect(response).to be_successful

    song_response = JSON.parse(response.body, symbolize_names: true)
    expect(song_response[:data][:attributes][:length]).to eq(song_update_params[:length])

    expect(updated_song.length).to eq(song_update_params[:length])
  end

  it "can destroy a song" do
    song_1 = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)

    delete api_v1_song_path(song_1)

    expect(response).to be_successful
    #  Either of these options below can verify this song no longer exists
    expect(Song.count).to eq(0)
    expect(Song.find_by(id: song_1.id)).to be_nil
    expect { Song.find(song_1.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
