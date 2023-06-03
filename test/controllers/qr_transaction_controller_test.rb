require "test_helper"

class QrTransactionControllerTest < ActionDispatch::IntegrationTest
  test "should get generator" do
    get qr_transaction_generator_url
    assert_response :success
  end
end
