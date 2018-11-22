class VideosController < ApplicationController
  def new
    @video = Video.new
  end

  def create
    uid = video_params[:link].split("=").last
    @video = Video.new(link: video_params[:link], uid: uid)
    if @video.save
      flash[:success] = "Video added"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:link)
  end
end
