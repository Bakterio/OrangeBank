require "application_system_test_case"

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = transactions(:one)
  end

  test "visiting the index" do
    visit transactions_url
    assert_selector "h1", text: "Transactions"
  end

  test "should create transaction" do
    visit transactions_url
    click_on "New transaction"

    fill_in "Amount", with: @transaction.amount
    fill_in "My note", with: @transaction.my_note
    fill_in "Note", with: @transaction.note
    fill_in "Recipient", with: @transaction.recipient_id
    fill_in "Sender", with: @transaction.sender_id
    fill_in "Variable symbol", with: @transaction.variable_symbol
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "should update Transaction" do
    visit transaction_url(@transaction)
    click_on "Edit this transaction", match: :first

    fill_in "Amount", with: @transaction.amount
    fill_in "My note", with: @transaction.my_note
    fill_in "Note", with: @transaction.note
    fill_in "Recipient", with: @transaction.recipient_id
    fill_in "Sender", with: @transaction.sender_id
    fill_in "Variable symbol", with: @transaction.variable_symbol
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "should destroy Transaction" do
    visit transaction_url(@transaction)
    click_on "Destroy this transaction", match: :first

    assert_text "Transaction was successfully destroyed"
  end
end
