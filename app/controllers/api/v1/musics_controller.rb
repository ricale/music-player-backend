class Api::V1::MusicsController < ApiController
  before_action :set_music, only: [:show, :update, :destroy]

  # GET /musics
  def index
    @musics = Music.all

    render json: @musics
  end

  # GET /musics/1
  def show
    render json: @music
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music
      @music = Music.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def music_params
      params.require(:music).permit(:name)
    end
end
