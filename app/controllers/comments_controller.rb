class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :load_song
  before_action :load_comment, only: %i(destroy edit update)

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      flash[:success] = t ".updated"
    else
      flash[:danger] = t ".update_failed"
    end
    redirect_to song_path @song
  end

  def create
    @comment = @song.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comments successfully."
      redirect_to song_path @song
    else
      render "new"
    end
  end

  def destroy
    if check_current_obj_user? @comment
      if @comment.destroy
        flash[:success] = t ".delete_successfully"
      else
        flash[:danger] = t ".delete_fail"
      end
    else
      flash[:danger] = t ".must_current_user"
    end
    redirect_to song_path @song
  end

  private

  def load_song
    @song = Song.find_by id: params[:song_id]
    return if @song
    flash[:danger] = "no song"
    redirect_to song_path @song
  end

  def load_comment
    @comment = @song.comments.find_by id: params[:id]
    return if @comment
    flash[:danger] = "no comment"
    redirect_to song_path @song
  end

  def comment_params
    params.require(:comment).permit :content
  end
end
