# frozen_string_literal: true

class Usr::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    if self.resource == nil
      user_params = params[:usr]

      if User.exists?(email: user_params[:email]) # If email is registered as old 'user'
        user = User.find_by(email: user_params[:email])
        if user.password_digest == user_params[:password] # If password is valid
          puts "Pass ok"
          new_user = Usr.new(email: user.email, password: user.password_digest, first_name: user.first_name, last_name: user.last_name)
          new_user.validate!
          if new_user.valid?
            new_user.save!
            sign_in(new_user)
            user.destroy!
            respond_with resource, location: after_sign_in_path_for(resource)
            return
          end
        end
      end
    end

    self.resource = warden.authenticate!(auth_options) # check if Usr is valid

    # Usr is valid --> Sign in
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
