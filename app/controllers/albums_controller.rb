class AlbumsController < ApplicationController
  before_action :logged_in_user
  before_action :load_album, only: %i(show edit update destroy)

  def show

  end

  def create
    @album = Album.new album_params
    if params[:songs].present?
      @album.transaction do
        @album.user = current_user
        @album.songs << Song.find(params[:songs])
        if @album.save
          flash[:success] = t ".create_success"
          redirect_to my_albums_url
        else
          flash.now[:warning] = t ".create_fail"
          render :new
        end
      end
    else
      flash.now[:warning] = t ".select_room_require"
      render :new
    end
  end

  def edit; end

  def update
    if @album.update album_params
      flash[:success] = t ".update_album_successfully"
      redirect_to my_albums_url
    else
      flash[:danger] = t ".update_album_fail"
      render :edit
    end
  end

  def destroy
    if check_current_obj_user? @album
      if @album.destroy
        flash[:success] = t ".delete_album_successfully"
      else
        flash[:danger] = t ".delete_album_fail"
      end
    else
      flash[:danger] = t ".must_current_user"
    end
    redirect_to my_albums_url
  end

  private

  def load_album
    @album = Album.find_by id: params[:id]
    return if @album
    flash[:danger] = t ".no_album"
    redirect_to root_url
  end

  def album_params
    params.require(:album).permit :name, :user_id,
      image_attributes: [:id, :image_url, :imageable_id, :imageable_type, :_destroy]
  end
end
