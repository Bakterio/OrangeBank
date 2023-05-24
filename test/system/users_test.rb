require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = usrs(:jimi)
  end

  test 'should log in' do
    visit new_usr_session_path

    fill_in 'usr_email', with: @user.email
    fill_in 'usr_password', with: 'test'

    click_on 'Log in'
    assert_current_path accounts_path
  end

  test 'should sing up' do
    visit new_usr_registration_path

    fill_in 'usr_email', with: 'ziggy@stardust.com'
    fill_in 'usr_first_name', with: @user.first_name
    fill_in 'usr_last_name', with: @user.last_name
    fill_in 'usr_password', with: 'test12345'
    fill_in 'usr_password_confirmation', with: 'test12345'

    click_on 'Sign up'
    assert_current_path accounts_path
  end

  test "shouldn't sign in with wrong password" do
    visit new_usr_session_path

    fill_in 'usr_email', with: @user.email
    fill_in 'usr_password', with: 'thisisawrongpassword'

    click_on 'Log in'
    assert_current_path new_usr_session_path
  end
end
