class ApplicationController < ActionController::Base
    def current_user
        if user_logged_in
            User.find(session[:user_id])
        end
    end

    def user_logged_in
        session[:user_id] == true
    end
end
