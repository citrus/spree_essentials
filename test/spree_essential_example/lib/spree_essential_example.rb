require "spree_essentials"

require "spree_essential_example/version"
require "spree_essential_example/engine"

module SpreeEssentialExample
  
  def self.tab
    { :label => "Examples", :route => "admin_examples" }
  end
  
  def self.sub_tab
    [ :examples, { :match_path => '/examples' }]
  end  
  
end

SpreeEssentials.register :example, SpreeEssentialExample
