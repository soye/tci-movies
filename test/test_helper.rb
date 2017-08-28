require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'
require 'capybara'
require 'capybara/poltergeist'
require 'capybara/dsl'
require 'capybara/minitest'

Capybara.register_driver :poltergeist do |app|
  options = {
      phantomjs_options: ['--ssl-protocol=any', '--ignore-ssl-errors=yes', '--web-security=false'],
      inspector: false
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 5

class ActiveSupport::TestCase
  fixtures :all
end

class Capybara::Rails::TestCase
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  Capybara.current_driver = Capybara.javascript_driver

  self.use_transactional_tests = false

  def teardown
    page.driver.reset!
  end
end