require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:jimi)
  end

  test "visiting the index" do
    visit log_in_path
    assert_selector "h1", text: "Log in"
  end

  test "should create user" do
    visit users_url
    click_on "New user"

    check "Admin" if @user.admin
    fill_in "Email", with: @user.email
    fill_in "First name", with: @user.first_name
    fill_in "Last name", with: @user.last_name
    fill_in "Passwd", with: @user.passwd
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "should update User" do
    visit user_url(@user)
    click_on "Edit this user", match: :first

    check "Admin" if @user.admin
    fill_in "Email", with: @user.email
    fill_in "First name", with: @user.first_name
    fill_in "Last name", with: @user.last_name
    fill_in "Passwd", with: @user.passwd
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "should destroy User" do
    visit user_url(@user)
    click_on "Destroy this user", match: :first

    assert_text "User was successfully destroyed"
  end
end
