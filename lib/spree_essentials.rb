require 'spree_core'
require 'spree_auth'

require 'rdiscount'
require 'meta_search' 
require 'acts-as-taggable-on'

module SpreeEssentials
  
  def self.register(extension)
    essentials << extension
  end
  
  def self.essentials
    @essentials ||= []
  end
  
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "static assets" do |app|
      app.middleware.insert_before ::Rack::Lock, ::ActionDispatch::Static, "#{config.root}/public"
    end
        
    def self.activate
      
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      
    end

    config.to_prepare &method(:activate).to_proc
    
  end
  
  class CustomHooks < Spree::ThemeSupport::HookListener
    
    insert_after :admin_tabs, 'admin/shared/contents_tab'

  end
  
end