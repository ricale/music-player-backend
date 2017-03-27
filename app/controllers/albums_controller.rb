class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]

  # GET /albums
  def index
    @albums  = Album.all

    artist_ids = @albums.map(&:artist_id).concat(@albums.map(&:album_artist_id)).uniq - [nil]
    @artists = Artist.where(id: artist_ids)

    album_ids = @albums.map(&:id)
    @tracks = Music.where(album_id: album_ids)
  end

  # GET /albums/1
  def show
    @artist = Artist.where(id: @album.artist_id).first
    @album_aritst = Artist.where(id: @album.album_artist_id).first
    @tracks = Music.where(album_id: @album.id)
  end

  # POST /albums
  def create
    @album = Album.new(album_params)

    if @album.save
      render json: @album, status: :created, location: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1
  def update
    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
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
