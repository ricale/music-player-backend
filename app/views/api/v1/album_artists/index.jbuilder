json.array! @album_artists do |artist|
  json.id   artist.id
  json.name artist.name
end
