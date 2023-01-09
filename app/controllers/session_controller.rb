class SessionController < ApplicationController
    def destory
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out"
    end

    def new
    end

    def create
        user = User.find_by(email: params[:email])

        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to accounts_path, notice: "Succesfully logged in"
        else 
            flash[:alert] = "Invalid email or password"
            render :new, status: :unprocessable_entity
        end
    end
end