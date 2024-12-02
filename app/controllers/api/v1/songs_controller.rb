class Api::V1::SongsController < ApplicationController
  def index
    render json: SongSerializer.new(Song.all)
  end

  def show
    render json: SongSerializer.new(Song.find(params[:id]))
  end

  def create
    song = Song.create(song_params)

    render json: song, status: 201
  end

  def update
    song = Song.find(params[:id])
    song.update(song_params)

    render json: SongSerializer.new(song)
  end

  def destroy
    song = Song.find(params[:id])
    song.destroy

    head :no_content
  end

  private

  def song_params
    params.permit(:title, :length, :play_count, :artist_id)
  end
end