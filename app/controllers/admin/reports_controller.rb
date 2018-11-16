class Admin::ReportsController < Admin::BaseController
  before_action :load_report, except: %i(index)

  def index
    @reports = Report.page(params[:page]).per 10
  end

  def show
    respond_to {|format| format.js}
  end

  def destroy
    if @report.destroy
      flash[:success] = t ".delete_successfully"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_reports_url
  end

  private

  def load_report
    @report = Report.find_by id: params[:id]
    return if @report
    flash[:danger] = t ".no_found_report"
    redirect_to admin_reports_url
  end
end
