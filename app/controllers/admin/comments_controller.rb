class Admin::CommentsController < Admin::BaseController
  before_action :load_comment, except: :index

  def index
    @comments = Comment.page(params[:page]).per 10
  end

  def show
    respond_to {|format| format.js}
  end

  def destroy
    if @comment.destroy
      flash[:success] = t ".delete_successfully"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_comments_url
  end

  private

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t ".found_comment"
    redirect_to admin_comments_url
  end
end
