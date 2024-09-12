class Api::V1::SongsController < ApplicationController
  def index
    render json: SongSerializer.format_songs(Song.all)
  end

  def show
    begin
      # happy path
      render json: SongSerializer.format_song(Song.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => exception
      # sad path
      render json: {
        errors: [
          {
            status: "404",
            message: exception.message
          }
        ]
      },
      status: :not_found
    end
  end

  def create
    begin
      song = Song.create!(song_params)
      render json: song, status: 201
    rescue ActiveRecord::RecordInvalid => error
      render json: {
        errors: [
          {
            "status": "422", 
            "message": error.message
          }
        ]
      }, status: 422
    end
  end

  # Other option for handling errors with #create
  # def create
  #   song = Song.new(song_params)
  #   if song.save
  #     render json: song, status: :created
  #   else
  #     render json: {
  #       errors: [
  #         {
  #           "status": "422", 
  #           "message": song.errors.full_messages.to_sentence # note we can extract error messages from song object!
  #         }
  #       ]
  #     }, status: 422
  #   end
  # end

  def update
    song = Song.find(params[:id])
    song.update(song_params)

    render json: SongSerializer.format_song(song)
  end

  def destroy
    song = Song.find(params[:id])
    song.destroy

    head :no_content
  end

  private

  def song_params
    params.require(:song).permit(:song, :title, :length, :play_count, :artist_id)
  end
end