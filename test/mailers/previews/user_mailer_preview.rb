# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/sing_up
  def sing_up
    UserMailer.with(user: User.first).sing_up
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/new_password
  def new_password
    UserMailer.new_password
  end
end
