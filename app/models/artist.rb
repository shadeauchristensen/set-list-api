class Artist < ApplicationRecord
  has_many :songs
  belongs_to :record_label

  # # songs method without associations
  # def songs
  #   Song.where(artist_id: self.id)
  # end

  def average_song_length
    self.songs.average(:length)
  end

  def song_count
    self.songs.count
    # note: self is optional. This solution could also be `songs.count`
  end

  def wrote_song?(song)
    # Version 1 WITH Assocations
    self.songs.include?(song)

    # Version 2 WITHOUT Associations
    # song.artist_id == self.id
  end
end
