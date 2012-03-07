RAILS_ROOT = ENV["RAILS_ROOT"]
if RAILS_ROOT.nil?
  puts 'Please specify ENV["RAILS_ROOT"] before `require "spree_essentials/testing/test_helper"`'
  exit
end

@env = File.join(RAILS_ROOT, "config/environment.rb")
if File.exists?(@env)
  require @env
else
  puts "#{@env} does not exist! Ensure that ENV[\"RAILS_ROOT\"] exists or try running `bundle exec dummier`"
  exit
end

require "rails/test_help"
require "shoulda"
require "paperclip/matchers"
require "factory_girl"
require "sqlite3"
require "ffaker"

ActionMailer::Base.delivery_method    = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "example.com"

Rails.backtrace_cleaner.remove_silencers!

class ActiveSupport::TestCase
  extend Paperclip::Shoulda::Matchers
end
