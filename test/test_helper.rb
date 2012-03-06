# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
  
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "spree_essentials/test_helper"

require "support/spree_essential_example"
