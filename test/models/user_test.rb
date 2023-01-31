require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @u = users(:deep_purple)
    @user = User.new(email: "praha@bratislava.sk", first_name: @u.first_name, last_name: @u.last_name, password_digest: @u.password_digest)
  end

  test "should create user" do
    assert_difference("User.count") do
      assert @user.save!
    end
  end

  test "should destroy user" do
    assert @user.save!
    assert_difference("User.count", -1) do
      @user.destroy!
    end
  end
end
