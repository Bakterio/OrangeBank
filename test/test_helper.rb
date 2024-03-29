ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'simplecov'

class ActiveSupport::TestCase
  SimpleCov.start
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def log_in
    user = users(:jimi)
    post log_in_path, params: { email: user.email, password: 'test' }
  end
end
