require "test_helper"

class QrTransactionControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = usrs(:jimi)
    sign_in @user
  end

  test 'should get generator' do
    get qr_generator_path
    assert_response :success
  end

  test 'should generate link' do
    post qr_generator_path recipient: @user.id, amount: 5000, note: 'test', variable_symbol: 666
    assert_redirected_to qr_generator_path
    assert_select 'a[href]', 1
    #assert_select 'a[href]', 'http://localhost:3000/new_transaction?amount=5000&note=test&recipient_id=' + @user.id.to_s + '&variable_symbol=666'
  end

  test 'should generate qrcode' do
    post qr_generator_path recipient: @user.id, amount: 5000, note: 'test', variable_symbol: 666
    assert_response :found
    assert_select 'img[src]', 1
    assert_select 'p'
  end
end
