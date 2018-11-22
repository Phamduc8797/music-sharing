class ReportsController < ApplicationController
  before_action :logged_in_user
  before_action :load_song

  def create
    @report = @song.reports.new report_params
    @report.user = current_user
    if @report.save
      flash[:success] = t "report_successfully"
      redirect_to song_path @song
    else
      flash[:danger] = t "report_failed"
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

  def report_params
    params.require(:report).permit :reason
  end
end
