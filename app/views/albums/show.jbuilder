json.id              @album.id
json.title           @album.title
json.images          @album.images
json.artist_id       @album.artist_id
json.album_artist_id @album.album_artist_id

if !@artist.blank?
  json.artist @artist,
    :id,
    :name
end

if !@album_artist.blank?
  json.album_artist @album_artist,
    :id,
    :name
end

json.tracks @tracks,
  :id,
  :title,
  :artist_id,
  :album_id,
  :album_artist_id,
  :discnum,
  :tracknum,
  :path,
  :images
