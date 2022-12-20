class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id]) # doesn't throw an error
        end
    end

    def require_user_logged_in
        if Current.user.nil?
            redirect_to log_in_path, notice: "You have to be logged for this operation" #,status: 403 <- causing "you will be redirect" page, I don't want it
        end
    end

    def set_current_account
        if session[:a]
            Current.account = Account.find_by(id: session[:a])
        end
    end
end
