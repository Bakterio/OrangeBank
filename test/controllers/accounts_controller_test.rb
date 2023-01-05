require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in
    @account = users(:jimi).accounts.first
  end

  test "should get index" do
    get accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_account_url
    assert_response :success
  end

  test "should create account" do
    assert_difference("Account.count") do
      post accounts_url, params: { account: { currency: @account.currency, name: @account.name } }
    end
    assert_redirected_to accounts_path
  end

  test "should show account" do
    get account_url(@account)
    assert_response :success
  end
end
