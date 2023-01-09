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

  test "should delete account" do
    assert_difference"Account.count", -1 do
      delete account_url(accounts(:empty))
    end
    assert_redirected_to accounts_path
  end

  test "shouldn't delete account with money on it" do
    assert_no_difference"Account.count" do
      delete account_url(@account)
    end
  end

  test "should raise error, need to pick account for transaction" do
    get new_transaction_path
    assert_redirected_to accounts_path
  end

  test "shouldn't use busy account" do
    transaction = transactions(:busy)
    get account_path(transaction.sender)
    transaction.sender.set_busy(true)
    post new_transaction_path, params: { transaction: { amount: transaction.amount, my_note: transaction.my_note, note: transaction.note, recipient_id: transaction.recipient_id } }
    assert_response :redirect
  end
end
