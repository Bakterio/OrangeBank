class SessionController < ApplicationController
  def destory
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out'
  end

  def new; end

  def create
  end
end
