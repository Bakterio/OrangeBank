class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_current_user
    return unless session[:user_id]

    current_usr = User.find_by(id: session[:user_id]) # doesn't throw an error
  end

  def require_user_logged_in
    return unless current_usr.nil?

    redirect_to log_in_path, notice: 'You have to be logged for this operation' # ,status: 403 <- causing "you will be redirect" page, I don't want it
  end

  def set_current_account
    return unless session[:a]

    Current.account = Account.find_by(id: session[:a])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  private

  def after_sign_in_path_for(_resource)
    accounts_path
  end
end
