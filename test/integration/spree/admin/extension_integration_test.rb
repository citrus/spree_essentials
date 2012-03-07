require "integration_test_helper"

class Spree::Admin::ExtensionIntegrationTest < SpreeEssentials::IntegrationCase
  
  setup do
    SpreeEssentials.essentials.clear
  end
  
  context "When no extensions are registered" do
    
    should "have a contents tab with only uploads in the sub nav" do
      visit spree.admin_orders_path
      within "#admin-menu" do
        assert has_link?("Content")
      end
      click_link "Content"
      within "#sub-menu" do
        assert has_link?("Uploads")
      end
      assert has_css?("#sub-menu li", :count => 1)
    end
  
  end
  
  context "When an extension is registered" do
    
    setup do
      SpreeEssentials.register :example, SpreeEssentialExample
    end
    
    teardown do
      SpreeEssentials.essentials.clear
    end
    
    should "have a contents tab with examples and uploads in the sub nav" do
      visit spree.admin_orders_path
      within "#admin-menu" do
        assert has_link?("Content")
      end
      click_link "Content"
      within "#sub-menu" do
        assert has_link?("Examples")
        assert has_link?("Uploads")
      end
      assert has_css?("#sub-menu li", :count => 2)
    end
    
  end
  
end
