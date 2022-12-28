require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jimi)
  end

  test "should create user" do
    assert_difference("User.count") do
      post sign_up_url, params: { user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name, password: @user.password_digest, password_confirmation: @user.password_digest} }
    end

    assert_redirected_to root_url
  end

  test "should log in" do
    post log_in_path, params: { user: { email: @user.email, password: "test" } }
    assert_redirected_to root_path, "Failed logged in"
  end
end
