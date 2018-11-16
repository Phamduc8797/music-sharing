class AlbumsController < ApplicationController
  before_action :logged_in_user
  before_action :load_album, only: %i(edit update destroy)

  def create
    @album = Album.new album_params
    @album.user = current_user
    if @album.save
      flash[:success] = t ".add_album_successfully"
    else
      flash[:danger] = t ".add_album_fail"
    end
    redirect_to my_albums_url
  end

  def edit
    @user = current_user
  end

  def update
    if @album.update_attributes album_params
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
    params.require(:album).permit :name, :user_id
  end
end
