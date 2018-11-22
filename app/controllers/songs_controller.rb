class SongsController < ApplicationController
  before_action :locked_account?, only: %i(create new)
  before_action :logged_in_user, except: %i(index show)
  before_action :load_song, except: %i(index create new add_to_album)
  before_action :load_category, only: %i(new edit update)

  def index
    @songs = Song.get_song
    render json:@songs.to_json(include: :image)
  end

  def show
    @albumsong = AlbumSong.new
    @song.increase_view
    @lyric =  @song.lyrics.build
    @report = @song.reports.build
    @lyrics = @song.lyrics.accepted.page(params[:page]).per Settings.page.show_lyric
    @comments = @song.comments.includes(:song).order_time.page(params[:page]).per 10
    @albums = Album.all
  end

  def new
    @song = Song.new
    @author = @song.authors.build
    @singer = @song.singers.build
  end

  def create
    @song = Song.new song_params
    @song.user = current_user
    if @song.save
      flash[:success] = t ".add_song_successfully"
      redirect_to my_songs_url
    else
      flash[:danger] = t ".add_song_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @song.update_attributes song_params
      flash[:success] = t ".song_updated"
      redirect_to my_songs_url
    else
      flash[:danger] = t ".song_update_failed"
      render :edit
    end
  end

  def destroy
    if check_current_obj_user? @song
      if @song.destroy
        flash[:success] = t ".delete_successfully"
      else
        flash[:danger] = t ".delete_fail"
      end
    else
      flash[:danger] = t ".must_current_user"
    end
    redirect_to my_songs_url
  end

  private

  def load_song
    @song = Song.find_by id: params[:id]
    return if @song
    flash[:danger] = t ".no_found_song"
    redirect_to root_url
  end

  def song_params
    params.require(:song).permit :name, :song_url, :category_id,
      authors_attributes: [:id, :name, :user_id, :_destroy],
      singers_attributes: [:id, :name, :user_id, :_destroy],
      image_attributes: [:id,
      :image_url, :imageable_id, :imageable_type, :_destroy]
  end

  def load_category
    @category_name = Category.by_name_cate
  end
end
