require "test_helper"

class UsrTest < ActiveSupport::TestCase
  setup do
    @u = usrs(:deep_purple)
  end

  test "should create usr" do
    assert_difference("Usr.count") do
      Usr.new(email: @u.email, first_name: @u.first_name, last_name: @u.last_name, password: "olomouc", password_confirmation: "olomouc")
    end
  end

  test "should destroy usr" do
    assert_difference("Usr.count", -1) do
      @u.destroy!
    end
  end
end
