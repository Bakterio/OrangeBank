require 'application_system_test_case'

class TransactionQrCodeTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @user = usrs(:jimi)
    sign_in @user
  end

  test 'should generate qr code' do
    visit qr_generator_path
  end
end
