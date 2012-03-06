module SpreeEssentialExample

  def self.tab
    { :label => "Examples", :route => "spree.admin_examples" }
  end
  
  def self.sub_tab
    [ :examples, { :match_path => '/examples' }]
  end  

  def self.independent?
    return true unless defined?(SpreeEssentials)
    !SpreeEssentials.respond_to?(:register)
  end
  
  class Engine < Rails::Engine    
    initializer :routes do |config| 
      Spree::Core::Engine.routes.append do
        namespace :admin do
          resources :examples
        end
      end
    end    
  end
  
end
