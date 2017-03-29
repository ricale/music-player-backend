json.array! @albums do |album|
  json.id              album.id
  json.title           album.title
  json.images          album.images
  # json.artist_id       album.artist_id
  json.album_artist_id album.album_artist_id

  # if !album.artist_id.blank? &&
  #   !@artists[album.artist_id].blank?
  #   json.artist @artists[album.artist_id],
  #     :id,
  #     :name
  # end

  if !album.album_artist_id.blank? &&
    !@artists[album.album_artist_id].blank?
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
