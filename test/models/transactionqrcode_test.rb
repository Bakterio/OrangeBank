require "test_helper"

class TransactionqrcodeTest < ActiveSupport::TestCase
  setup do
    @google = transactionqrcodes :google
  end

  test "can't save qrcode without usr" do
    assert_raises ActiveRecord::NotNullViolation do
      Transactionqrcode.create!(link: @google.link)
    end
  end
end
