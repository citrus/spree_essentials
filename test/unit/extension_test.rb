require_relative '../test_helper'


module SpreeEssentialSomething

  def self.tab
    [:somethings, :something_images, :something_products ]
  end
  
  def self.sub_tab
    [:somethings, { :label => 'admin.subnav.somethings', :match_path => '/somethings' }]
  end

end




class ExtensionTest < Test::Unit::TestCase
    
  def setup
    SpreeEssentials.essentials.clear
  end  
  
  should "start with zero essentials" do
    assert_equal 0, SpreeEssentials.essentials.length  
  end
  
  should "register an essential" do
    SpreeEssentials.register :something, SpreeEssentialSomething
    assert_equal 1, SpreeEssentials.essentials.length
  end
          
end



