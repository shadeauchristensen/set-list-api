class SongSerializer
  include JSONAPI::Serializer
  attributes :title, :length, :play_count
end
