json.id   @album_artist.id
json.name @album_artist.name

json.albums @albums,
  :id,
  :title,
  :images,
  :album_artist_id
