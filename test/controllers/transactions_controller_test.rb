require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in usrs(:jimi)
    @transaction = transactions(:same_currency)
  end

  test "should send transaction" do
    assert_difference("Transaction.count") do
      post new_transaction_path, params: { transaction: { amount: @transaction.amount, my_note: @transaction.my_note, note: @transaction.note,
                                                          sender_id: @transaction.sender_id, recipient_id: @transaction.recipient_id } }
    end

    assert_redirected_to account_path(@transaction.sender)
  end

  test "should send transaction with rounded amount" do
    assert_difference("Transaction.count") do
      post new_transaction_path, params: { transaction: { amount: "3.00", my_note: @transaction.my_note, note: @transaction.note,
                                                          sender_id: @transaction.sender_id, recipient_id: @transaction.recipient_id } }
    end

    assert_redirected_to account_path(@transaction.sender)
  end

  test "should send transaction to account in another currency" do
    transaction = transactions(:different_currency)
    assert_difference("Transaction.count") do
      post new_transaction_path, params: { transaction: { amount: transaction.amount, my_note: transaction.my_note,
                                                          note: transaction.note, recipient_id: transaction.recipient_id, sender_id: transaction.sender_id } }
    end

    assert_redirected_to account_path(transaction.sender)
  end

  test "shouldn't do transaction with participant who doesn't exist" do
    post new_transaction_path, params: {transaction: {sender_id: @transaction.sender.id, percipient_id: 0}}
    assert_response 400
  end
end
