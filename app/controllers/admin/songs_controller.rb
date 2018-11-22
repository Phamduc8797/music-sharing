class Admin::SongsController < Admin::BaseController
  before_action :load_song, except: %i(index)

  def index
    @songs = Song.includes(:comments, :lyrics, :reports).page(params[:page]).per 20
  end

  def destroy
    if @song.destroy
      flash[:success] = t ".delete_successfully"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_songs_url
  end

  private

  def load_song
    @song = Song.find_by id: params[:id]
    return if @song
    flash[:danger] = t ".no_found_song"
    redirect_to admin_songs_url
  end
end
