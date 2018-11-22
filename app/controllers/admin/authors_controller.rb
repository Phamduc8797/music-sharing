class Admin::AuthorsController < Admin::BaseController
  before_action :load_author, only: %i(edit update destroy)

  def index
    @authors = Author.select_fields.by_lastest.page(params[:page]).per Settings.show
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    @author.user = current_user
    if @author.save
      flash[:success] = t ".add_success", name: @author.name
      redirect_to admin_authors_path
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @author.update author_params
      flash[:success] = t ".author_update"
      redirect_to admin_authors_path
    else
      render :edit
    end
  end

  def destroy
    unless @author.songs.any?
      if @author.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".warning"
      end
    else
      flash[:danger] = t ".has_songs"
    end
    redirect_to admin_authors_path
  end

  private

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:danger] = t ".not_found", id: params[:id]
    redirect_to admin_authors_path
  end

  def author_params
    params.require(:author).permit :name, :info, image_attributes: [:id,
      :image_url, :imageable_id, :imageable_type, :_destroy]
  end
end
