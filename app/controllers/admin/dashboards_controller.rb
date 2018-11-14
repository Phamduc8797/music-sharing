class Admin::DashboardsController < Admin::BaseController
  def index
    @lyrics = Lyric.all
  end
end
