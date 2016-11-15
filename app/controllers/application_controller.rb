class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit

  #always get the current user
  before_action :current_user

#  after_action :verify_authorized, :except => :index
#  after_action :verify_policy_scoped, :only => :index

#  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

#  def pundit_user
#    current_user = User.find(session[:user_id])
#    PhxUserContext.new(current_user, session[:user_id], "menu1", "sub")
#  end

  before_filter :set_cache_headers

  private

  def user_not_authorized

    flash[:alert] = "You are not authorized to perform this action."
#    redirect_to(request.referrer || root_path)
    redirect_to root_path
  end

  def set_cache_headers
      response.headers["Cache-Control"] = "no-cache, no-store"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
