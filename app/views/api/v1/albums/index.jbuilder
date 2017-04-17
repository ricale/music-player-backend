json.array! @albums do |album|
  json.id              album.id
  json.title           album.title
  json.images          album.images
  json.album_artist_id album.album_artist_id

  json.artists (@artists.select {|id,a| @tracks[album.id].map(&:artist_id).include?(id)}.values),
    :id,
    :name

  if !album.album_artist_id.blank?
    json.album_artist @artists[album.album_artist_id],
      :id,
      :name
  end

  json.tracks @tracks[album.id],
    :id,
    :title,
    :artist_id,
    :album_id,
    :album_artist_id,
    :discnum,
    :tracknum,
    :path,
    :images
end
