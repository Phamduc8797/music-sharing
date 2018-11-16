class LyricsController < ApplicationController
  before_action :load_song

  def create
    @lyric = @song.lyrics.new lyric_params
    @lyric.user_id = current_user.id
    if @lyric.save
      flash[:success] = "Create lyric successfully. Wait admin accept!"
      redirect_to song_path @song
    else
      render "new"
    end
  end

  private

  def load_song
    @song = Song.find_by id: params[:song_id]
    return if @song
    flash[:danger] = "no song"
    redirect_to song_path @song
  end

  def lyric_params
    params.require(:lyric).permit :content, :accepted
  end
end
