require 'rails/test_help'
require 'shoulda'
require 'factory_girl'
require 'sqlite3'
require 'faker'

ActionMailer::Base.delivery_method    = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "example.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
require "selenium/webdriver"

Capybara.default_driver   = :selenium
Capybara.default_selector = :css

# Define a bare test case to use with Capybara
class ActiveSupport::IntegrationCase < ActiveSupport::TestCase
  
  include Capybara
  include Rails.application.routes.url_helpers
  
  self.use_transactional_fixtures = false
  
  def assert_seen(text, opts={})
    if opts[:within]
      within(opts[:within]) do
        assert has_content?(text)
      end
    else
      assert has_content?(text)
    end
  end
  
  def assert_flash(key, text)
    within(".flash.#{key}") do
      assert_seen(text)
    end
  end

end
