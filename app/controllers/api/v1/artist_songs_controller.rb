class Api::V1::ArtistSongsController < ApplicationController
  def index
    artist = Artist.find(params[:artist_id])
    render json: SongSerializer.new(artist.songs)
  end

  def create
    artist = Artist.find(params[:artist_id])
    song = artist.songs.create(song_params)

    render json: SongSerializer.new(song), status: 201
  end

  private

  def song_params
    params.permit(:title, :length, :play_count, :artist_id)
  end
end