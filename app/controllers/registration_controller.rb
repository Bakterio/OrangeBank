class RegistrationController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Successfully singed up"
    else
      # redirect_to sing_up_path, notice: "Something went wrong, please, check your input", status: 418 # teapot hehe
      render :new, status: 418
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
