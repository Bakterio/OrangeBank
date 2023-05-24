require 'test_helper'

class UsrControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = usrs(:deep_purple)
  end

  test 'should sing up' do
    assert_difference('Usr.count') do
      post usr_registration_path, params: { usr: { email: 'david@bowie.com', first_name: @user.first_name,
                                                   last_name: @user.last_name, password: @user.encrypted_password,
                                                   password_confirmation: @user.encrypted_password } }
    end

    assert_redirected_to accounts_path
  end

  test 'should sing in' do
    post usr_session_path, params: { usr: { email: @user.email, password: 'knockingatyourbackdoor' } }

    assert_redirected_to accounts_path
  end

  test 'should sign out' do
    sign_in @user
    delete destroy_usr_session_path
    assert_redirected_to root_path
  end

  test 'should migrate user to usr' do
    user = users(:karel_novak)
    assert_difference('Usr.count') do
      assert_difference('User.count', -1) do
        post usr_session_path, params: { usr: { email: user.email, password: 'ustinadlabem' } }
      end
    end
    assert_response 302, "HTTP response is not 302 - found"
    usr = Usr.find_by(email: user.email)
    assert_equal usr.first_name, user.first_name
    assert_equal usr.last_name, user.last_name
  end
end
