class RegistrationController < ApplicationController
  def new
    @user = Usr.new
  end

  def create
    @user = Usr.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully singed up"
    else
      flash[:alert] = "Something went wrong, please, check your input"
      render :new, status: 418
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
