class Api::V1::AlbumArtistsController < ApplicationController
  before_action :set_album_artist, only: [:show, :update, :destroy]

  # GET /album_artists
  def index
    @album_artists = Artist.where(artist_type_id: Artist::TYPE_ALBUM_ARTIST)
  end

  # GET /album_artists/1
  def show
    @albums = Album.where(album_artist_id: @album_artist.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album_artist
      @album_artist = Artist.find(params[:id])
    end

    # # Only allow a trusted parameter "white list" through.
    # def artist_params
    #   params.require(:artist).permit(:name)
    # end
end
