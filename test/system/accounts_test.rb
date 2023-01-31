require 'application_system_test_case'

class AccountsTest < ApplicationSystemTestCase
  setup do
    @account = accounts(:one)
    visit log_in_path
    assert_selector 'h1', text: 'Log in'
    user = users(:jimi)
    fill_in 'email', with: user.email
    fill_in 'password', with: 'test'
    click_on 'Log in'
    assert_current_path accounts_path
  end

  test 'visiting the index' do
    visit accounts_url
    assert_selector 'h1', text: 'Accounts'
  end

  test 'should create account' do
    visit accounts_url
    click_on 'Create new account'

    fill_in 'currency', with: @account.currency
    fill_in 'Name', with: @account.name
    fill_in 'Owener', with: @account.user_id
    fill_in 'Value', with: @account.value
    click_on 'Create Account'

    assert_text 'Account was successfully created'
  end

  test 'should update Account' do
    visit accounts_path
    assert_selector '.accounts_list' do
      click_on 'My first account'
    end
    assert_current_path account_path(@account)
    click_link title: 'edit_account'
    assert_text 'Rename account'
    fill_in 'Name', with: @account.name
    click_on 'Rename account'

    assert_text 'Account was successfully renamed'
  end

  test 'should destroy Account' do
    visit account_url(@account)
    click_on 'Destroy this account', match: :first

    assert_text 'Account was successfully destroyed'
  end
end
