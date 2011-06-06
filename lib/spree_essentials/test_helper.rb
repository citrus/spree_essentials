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
