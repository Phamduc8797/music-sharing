class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "users.login_request"
      redirect_to root_path
    end
  end

  def not_logged_in
    if logged_in?
      flash[:warning] = t "users.invalid_action"
      redirect_to root_path
    end
  end
end
