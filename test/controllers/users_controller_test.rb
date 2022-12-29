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
    @request.session[:user_id] == @user.id
    get accounts_path
    assert_response :success
  end
end
