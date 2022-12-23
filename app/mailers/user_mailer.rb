class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sing_up.subject
  #
  def sing_up
    @user = params[:user]

    mail to: email_address_with_name(@user.email, @user.full_name), subject: "Welcome to OrangeBank"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_password.subject
  #
  def new_password
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
