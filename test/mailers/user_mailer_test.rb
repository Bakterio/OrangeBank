require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'sing_up' do
    user = users(:jimi)
    mail = UserMailer.with(user: user).sing_up
    assert_equal 'Welcome to OrangeBank', mail.subject
    assert_equal [user.email], mail.to
  end

  test 'new_password' do
    mail = UserMailer.new_password
    assert_equal 'New password', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
