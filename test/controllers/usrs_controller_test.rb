require "test_helper"

class UsrControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = usrs(:deep_purple)
  end

  test "should sing up" do
    assert_difference("Usr.count") do
      post usr_registration_path, params: { usr: { email: "david@bowie.com", first_name: @user.first_name, last_name: @user.last_name,
                                                   password: @user.encrypted_password, password_confirmation: @user.encrypted_password} }
    end

    assert_redirected_to accounts_path
  end

  test "should sing in" do
    post usr_session_path, params: { usr: {email: @user.email, password: "knockingatyourbackdoor" }}

    assert_redirected_to accounts_path
  end

  test "should sign out" do
    sign_in @user
    delete destroy_usr_session_path
    assert_redirected_to root_path
  end
end