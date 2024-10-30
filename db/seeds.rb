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
Artist.destroy_all
PlaylistSong.destroy_all
Playlist.destroy_all


prince = Artist.create!(name: "Prince")
rtj = Artist.create!(name: "Run The Jewels")
caamp = Artist.create!(name: "Caamp")
jgb = Artist.create!(name: "Jerry Garcia Band")
billie = Artist.create!(name: "Billie Eilish")
lcd = Artist.create!(name: "LCD Soundsystem")

beret = prince.songs.create!(title: "Raspberry Beret", length: 345, play_count: 34)
purple = prince.songs.create!(title: "Purple Rain", length: 524, play_count: 19)

legend = rtj.songs.create!(title: "Legend Has It", length: 2301, play_count: 2300000)

caamp.songs.create!(title: "26", length: 940, play_count: 150000)
vagabond = caamp.songs.create!(title: "Vagabond", length: 240, play_count: 120000)

jgb.songs.create!(title: "Aint No Bread In The Breadbox", length: 540, play_count: 12000)
jgb.songs.create!(title: "The Harder They Come", length: 240, play_count: 120000)

billie.songs.create!(title: "bury a friend", length: 340, play_count: 1200000)
bad_guy = billie.songs.create!(title: "bad guy", length: 240, play_count: 100000)

lcd.songs.create!(title: "Someone Great", length: 500, play_count: 1000000)
lcd.songs.create!(title: "I Can Change", length: 640, play_count: 100000)

nice_songs = Playlist.create!(name: "Nice Songs")
amazing_songs = Playlist.create!(name: "Amazing Songs")

PlaylistSong.create!(playlist: nice_songs, song: beret)
PlaylistSong.create!(playlist: nice_songs, song: bad_guy)
PlaylistSong.create!(playlist: nice_songs, song: vagabond)
PlaylistSong.create!(playlist: amazing_songs, song: purple)
PlaylistSong.create!(playlist: amazing_songs, song: legend)
