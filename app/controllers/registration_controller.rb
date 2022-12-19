class RegistrationController < ApplicationController
  def new
    @user = User.new
  end

  def edit
  end
end
