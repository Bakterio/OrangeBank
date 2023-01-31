require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = usrs(:deep_purple)
  end

  test "should create user" do
    assert_difference("Usr.count") do
      post usr_registration_path, params: { usr: { email: "david@bowie.com", first_name: @user.first_name, last_name: @user.last_name,
                                                   password: @user.encrypted_password, password_confirmation: @user.encrypted_password} }

    end

    assert_redirected_to root_path
  end

end