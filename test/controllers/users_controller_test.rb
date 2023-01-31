require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = usrs(:jimi)
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
