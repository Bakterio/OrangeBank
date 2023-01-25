require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = usrs(:jimi)
  end

  test "should create usr" do
    assert_difference("Usr.count") do
      post sign_up_url, params: { user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name, password: @user.encrypted_password, password_confirmation: @user.encrypted_password}}
    end

    assert_redirected_to root_path
  end

  test "should log out" do
    sign_in @user
    delete destroy_usr_session_path
    assert_redirected_to root_path
  end

  test "should log in" do
    sign_in @user
    get accounts_path
    assert_response :success
  end

  test "should get log in" do
    get new_usr_session_path
    assert_response :success
  end

  test "should get sign up" do
    get new_usr_registration_path
    assert_response :success
  end
end
