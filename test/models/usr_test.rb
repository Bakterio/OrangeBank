require 'test_helper'

class UsrTest < ActiveSupport::TestCase
  setup do
    @u = usrs(:deep_purple)
  end

  test 'should create usr' do
    assert_difference('Usr.count') do
      user = Usr.new(email: 'praha@bratislava.sk', first_name: @u.first_name, last_name: @u.last_name,
                     password: 'olomouc', password_confirmation: 'olomouc')
      user.save!
    end
  end

  test 'should destroy usr' do
    user = Usr.new(email: 'praha@bratislava.com', first_name: @u.first_name, last_name: @u.last_name,
                   password: 'olomouc', password_confirmation: 'olomouc')
    user.save!
    assert_difference('Usr.count', -1) do
      user.destroy!
    end
  end
end
