class MainController < ApplicationController
  def index; end

  def about_us; end

  def our_services; end

  def debug
    @user = User.find_by(id: session[:user_id])
  end
end
