require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:same_currency)
    log_in
    get account_path(@transaction.sender)
  end

  test "should send transaction" do
    assert_difference("Transaction.count") do
      post new_transaction_path, params: { transaction: { amount: @transaction.amount, my_note: @transaction.my_note, note: @transaction.note, recipient_id: @transaction.recipient_id } }
    end

    assert_redirected_to account_path(@transaction.sender)
  end

  test "should send transaction with rounded amount" do
    assert_difference("Transaction.count") do
      post new_transaction_path, params: { transaction: { amount: "3.00", my_note: @transaction.my_note, note: @transaction.note, recipient_id: @transaction.recipient_id } }
    end

    assert_redirected_to account_path(@transaction.sender)
  end

  test "should send transaction to account in another currency" do
    transaction = transactions(:different_currency)
    get account_path(transaction.sender)
    assert_difference("Transaction.count") do
      get account_path(transaction.sender)
      post new_transaction_path, params: { transaction: { amount: transaction.amount, my_note: transaction.my_note, note: transaction.note, recipient_id: transaction.recipient_id } }
    end

    assert_redirected_to account_path(transaction.sender)
  end
end
