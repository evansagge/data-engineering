class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_user

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user=(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def require_user
    unless current_user
      store_location
      redirect_to login_path
      return false
    end
  end

  def store_location
    if request.get?
      session[:return_to] =request.url
    else
      session[:return_to] =request.referer
    end
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
