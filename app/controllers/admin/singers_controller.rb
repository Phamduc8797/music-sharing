class Admin::SingersController < Admin::BaseController
  before_action :load_singer, only: %i(edit update destroy)

  def index
    @singers = Singer.select_fields.by_lastest.page(params[:page]).per Settings.show
  end

  def new
    @singer = Singer.new
  end

  def create
    @singer = Singer.new singer_params
    @singer.user = current_user
    if @singer.save
      flash[:success] = t ".add_success", name: @singer.name
      redirect_to admin_singers_path
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @singer.update singer_params
      flash[:success] = t ".singer_update"
      redirect_to admin_singers_path
    else
      render :edit
    end
  end

  def destroy
    unless @singer.songs.any?
      if @singer.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".warning"
      end
    else
      flash[:danger] = t ".has_songs"
    end
    redirect_to admin_singers_path
  end

  private

  def load_singer
    @singer = Singer.find_by id: params[:id]
    return if @singer
    flash[:danger] = t ".not_found", id: params[:id]
    redirect_to admin_singers_path
  end

  def singer_params
    params.require(:singer).permit :name, :info, image_attributes: [:id,
      :image_url, :imageable_id, :imageable_type, :_destroy]
  end
end
