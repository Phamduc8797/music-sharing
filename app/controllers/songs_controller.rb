class SongsController < ApplicationController
  before_action :logged_in_user, except: %i(index show)
  before_action :load_song, only: %i(destroy show edit update)
  before_action :load_category, only: %i(new edit update search filter)
  before_action :load_author, :load_singer, only: %i(search filter)

  def index
    @songs = Song.get_song
    render json:@songs.to_json(include: [:image, :authors, :singers])
  end

  def show
    @albumsong = AlbumSong.new
    @song.increase_view
    @lyric =  @song.lyrics.build
    @report = @song.reports.build
    @lyrics = @song.lyrics.accepted.page(params[:page]).per Settings.page.show_lyric
    @comments = @song.comments.includes(:song).order_time.page(params[:page]).per 10
    @albums = Album.all
    @user_id = current_user.id
    @is_liked = @song.is_liked @user_id
  end

  def recommend_song
    recommend_songs = current_user.recommend_songs
    @list_song = Song.where(id: recommend_songs).order(id: :desc)
    render json:@list_song.to_json(include: [:category, :authors, :image])
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

  def search
    @songs = Song.search(params[:q]).page(params[:page]).per Settings.record_per_page
  end

  def filter
    filtering_params(params).each do |key, value|
      @songs = Song.public_send(key, value) if value.present?
    end
    render json:{
      search_result: render_to_string(@songs)
    }, status: :ok
  end

  def chart_songs
    @songs = Song.order(view: :desc).limit(5)
    render json:@songs.to_json(include: [:image])
  end

  private

  def load_song
    @song = Song.find_by id: params[:id]
    return if @song
    flash[:danger] = t ".no_found_song"
    redirect_to root_url
  end

  def filtering_params params
    params.slice(:filter_category_id, :filter_author_id, :filter_singer_id, :sort_name)
  end

  def song_params
    params.require(:song).permit :name, :song_url, :category_id,
      authors_attributes: [:id, :name, :user_id, :_destroy],
      singers_attributes: [:id, :name, :user_id, :_destroy],
      image_attributes: [:id,
      :image_url, :imageable_id, :imageable_type, :_destroy]
  end

  def load_category
    @category_name = Category._name
  end

  def load_author
    @authors = Author._name
  end

  def load_singer
    @singers = Singer._name
  end
end
