class Song < ApplicationRecord
  belongs_to :artist

  validates :title, presence: true
  validates :length, presence: true, numericality: true
  validates :play_count, presence: true, numericality: true

end