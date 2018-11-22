class StaticPagesController < ApplicationController
  def index
    @videos = Video.order("created_at DESC").page(params[:page]).per(2)
  end
end
