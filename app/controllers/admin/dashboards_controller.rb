class Admin::DashboardsController < Admin::BaseController
  def index
    @lyrics = Lyric.all
    @reports = Report.all
    @comments = Comment.all
  end
end
