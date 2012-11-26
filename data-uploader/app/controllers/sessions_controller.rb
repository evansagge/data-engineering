class SessionsController < ApplicationController

  skip_before_filter :require_user, except: :destroy

  def new
  end

  def create
    self.current_user = User.authenticate!(request.env["omniauth.auth"])
    flash[:notice] = "Successfully logged in as #{current_user.name} using #{current_user.provider.titleize}"
    redirect_back_or_default root_url
  rescue ActiveRecord::ActiveRecordError => e
    flash.now[:alert] = "Sign in failed. Please try again."
    render :new
  end

  def failure
    flash.now[:alert] = "Sign in failed. Please try again."
    render :new
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

end