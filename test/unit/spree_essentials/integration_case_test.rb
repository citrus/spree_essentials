require 'test_helper'
require "spree_essentials/testing/integration_case"

class SpreeEssentials::IntegrationCaseTest < ActiveSupport::TestCase
  
  setup do
    @testcase = SpreeEssentials::IntegrationCase.new(nil)
  end
  
  should "subclass ActiveSupport::TestCase" do
    assert_equal ActiveSupport::TestCase, SpreeEssentials::IntegrationCase.superclass
  end
  
  should "include Spree::Core::Engine routes as spree" do
    assert_equal Spree::Core::Engine.routes.url_helpers, @testcase.spree
  end

  %w(assert_seen assert_flash assert_title assert_meta).each do |meth|
    should "include have ##{meth} matcher" do
      assert @testcase.respond_to?(meth)
    end    
  end
  
end
