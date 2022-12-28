require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:jimi)
  end

  test "should log in" do
    visit log_in_path

    fill_in "email", with: @user.email
    fill_in "password", with: "test"

    click_on "Log in"
    assert_current_path root_path
  end

  test "should sing up" do
    visit sign_up_path

    fill_in "user_email", with: @user.email
    fill_in "user_first_name", with: @user.first_name
    fill_in "user_last_name", with: @user.last_name
    fill_in "user_password", with: "test12345"
    fill_in "user_password_confirmation", with: "test12345"

    click_on "Sign up"
    assert_current_path root_path
  end
end