require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'
require 'capybara'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'capybara/dsl'
require 'capybara/minitest'
require 'vcr'
require 'webmock/minitest'

Capybara.register_driver :poltergeist do |app|
  options = {
      phantomjs_options: ['--ssl-protocol=any', '--ignore-ssl-errors=yes', '--web-security=false'],
      inspector: false
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 5

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = true
end

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