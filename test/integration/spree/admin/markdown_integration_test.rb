require "integration_test_helper"

class Spree::Admin::MarkdownIntegrationTest < SpreeEssentials::IntegrationCase
  
  should "render markdown body with xhr" do
    visit spree.admin_examples_path
  end
    
end
