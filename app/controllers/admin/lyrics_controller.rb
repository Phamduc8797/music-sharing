class Admin::LyricsController < Admin::BaseController
  before_action :load_lyric, except: %i(index)

  def index
    @lyrics = Lyric.page(params[:page]).per 10
  end

  def show
    respond_to {|format| format.js}
  end

  def unaccept
    if @lyric.unaccept_lyric!
      flash[:success] = t ".unaccept_successfully"
    else
      flash[:danger] = t ".unaccept_failed"
    end
    redirect_to admin_lyrics_url
  end

  def accept
    if @lyric.accept_lyric!
      flash[:success] = t ".accept_successfully"
    else
      flash[:danger] = t ".accept_failed"
    end
    redirect_to admin_lyrics_url
  end

  def destroy
    if @lyric.destroy
      flash[:success] = t ".delete_successfully"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_lyrics_url
  end

  private

  def load_lyric
    @lyric = Lyric.find_by id: params[:id]
    return if @lyric
    flash[:danger] = t ".no_found_lyric"
    redirect_to admin_lyrics_url
  end
end
