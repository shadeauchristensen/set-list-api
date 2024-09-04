# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Song.destroy_all

Song.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
Song.create!(title: 'Purple Rain', length: 524, play_count: 19)

Song.create!(title: 'Legend Has It', length: 2301, play_count: 2300000)
Song.create!(title: 'Talk to Me', length: 2301, play_count: 2300000)

Song.create!(title: '26', length: 940, play_count: 150000)
Song.create!(title: 'Vagabond', length: 240, play_count: 120000)

Song.create!(title: 'Aint No Bread In The Breadbox', length: 540, play_count: 12000)
Song.create!(title: 'The Harder They Come', length: 240, play_count: 120000)

Song.create!(title: 'bury a friend', length: 340, play_count: 1200000)
Song.create!(title: 'bad guy', length: 240, play_count: 100000)

Song.create!(title: 'Someone Great', length: 500, play_count: 1000000)
Song.create!(title: 'I Can Change', length: 640, play_count: 100000)
