ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "factory_bot"

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include FactoryBot::Syntax::Methods
end
