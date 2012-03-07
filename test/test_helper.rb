# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
ENV["RAILS_ROOT"] = File.expand_path("../dummy",  __FILE__)

require "spree_essentials/testing/test_helper"
require "support/spree_essential_example"
