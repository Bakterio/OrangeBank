require "test_helper"

class DonateControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sender = accounts(:one)
  end

  test "should get new" do
    get create_donate_path(account: @sender.id)
    assert_response :success
  end
end
