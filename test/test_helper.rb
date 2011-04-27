# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
  
require 'rubygems'
require 'spork'

Spork.prefork do
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require 'spree_essentials/test_helper'
end

Spork.each_run do

  

  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
  include HelperMethods
end

## Configure Rails Envinronment
#ENV["RAILS_ENV"] = "test"
#  
#require 'rubygems'
#require 'spork'
#
#
#Spork.prefork do
#
#  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
#  require 'rails/test_help'
#  require 'shoulda'
#  require 'factory_girl'
#  require 'sqlite3'
#  require 'faker'
#  
#  ActionMailer::Base.delivery_method    = :test
#  ActionMailer::Base.perform_deliveries = true
#  ActionMailer::Base.default_url_options[:host] = "example.com"
#  
#  Rails.backtrace_cleaner.remove_silencers!
#  
#  # Configure capybara for integration testing
#  require "capybara/rails"
#  require "selenium/webdriver"
#  
#  Capybara.default_driver = :selenium
#  
#  class ActionController::TestCase
#    include Devise::TestHelpers
#  end
#  
#end
#
#
#Spork.each_run do
#  
#  # Load support files
#  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
#  include HelperMethods
# 
#end
