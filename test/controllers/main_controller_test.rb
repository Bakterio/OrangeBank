require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get main_index_url
    assert_response :success
  end

  test "should get about_us" do
    get main_about_us_url
    assert_response :success
  end

  test "should get our_services" do
    get main_our_services_url
    assert_response :success
  end
end
