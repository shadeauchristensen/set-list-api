class Song < ApplicationRecord
  belongs_to :artist

  # # artist method without associations
  # def artist
  #   Artist.find(self.artist_id)
  # end

  def artist_name
    self.artist.name
    # note: self is optional. This solution could also be `artist.name`
  end

  def other_artist_songs
    self.artist.songs.where.not(id: self.id)
  end

  def self.song_count
    self.count
  end
end
