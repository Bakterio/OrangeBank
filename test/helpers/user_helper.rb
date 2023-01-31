module SignInHelper
  def sign_in_as(user)
    post log_in_path(email: user.email, password: user.password_digest)
  end
end

class ActionDispatch::IntegrationTest
  include SignInHelper
end
