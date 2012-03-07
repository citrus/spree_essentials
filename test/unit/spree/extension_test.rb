require 'test_helper'

class ExtensionTest < ActiveSupport::TestCase
    
  def setup
    SpreeEssentials.essentials.clear
  end  
  
  should "have a hash as it's tab" do
    tab = { :label => "Examples", :route => "admin_examples" }
    assert_equal tab, SpreeEssentialExample.tab
  end
  
  should "have an array as it's subtab" do
    sub_tab = [ :examples, { :match_path => '/examples' }]
    assert_equal sub_tab, SpreeEssentialExample.sub_tab
  end
  
  should "start with zero essentials" do
    assert_equal 0, SpreeEssentials.essentials.length  
  end
  
  should "register an essential" do
    SpreeEssentials.register :example, SpreeEssentialExample
    assert_equal 1, SpreeEssentials.essentials.length
  end
      
  should "check if spree essentials has an extension" do
    SpreeEssentials.register :example, SpreeEssentialExample
    assert SpreeEssentials.has?(:example)
  end
  
end
