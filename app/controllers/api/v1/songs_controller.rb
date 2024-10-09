class Api::V1::SongsController < ApplicationController
  before_action :authenticate_user

  def index
    render json: Song.all
  end

  def show
    render json: Song.find(params[:id])
  end

  def create
    render json: Song.create(song_params)
  end

  def update
    render json: Song.update(params[:id], song_params)
  end

  def destroy
    render json: Song.delete(params[:id])
  end

  private

  def song_params
    params.require(:song).permit(:title, :length, :play_count )
  end

end