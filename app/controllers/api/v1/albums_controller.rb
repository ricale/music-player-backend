class Api::V1::AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]

  # GET /albums
  def index
    @albums  = Album.all

    # artist_ids = @albums.map(&:artist_id).concat(@albums.map(&:album_artist_id)).uniq - [nil]
    artist_ids = @albums.map(&:album_artist_id).uniq
    @artists = Artist.where(id: artist_ids).inject({}) do |hash, artist|
      hash.merge({artist.id => artist})
    end

    album_ids = @albums.map(&:id)
    @tracks = Music.where(album_id: album_ids).inject({}) do |hash, music|
      hash[music.album_id] ||= []
      hash[music.album_id] << music
      hash
    end
  end

  # GET /albums/1
  def show
    @album_artist = Artist.where(id: @album.album_artist_id).first
    @tracks = Music.where(album_id: @album.id)
    @artists = Artist.where(id: @tracks.map(&:artist_id))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.require(:album).permit(:title)
    end
end
