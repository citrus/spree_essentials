require 'spree_core'
require 'spree_auth'
require 'rdiscount'

module SpreeEssentials
  
  class << self
  
    # Stores an essential-aware extension for use later
    def register(key, extension)
      essentials[key] = extension
    end
        
    # Looks up an extension name 
    def has?(essential)
      essentials.keys.include?(essential.to_sym)
    end
    
    # Returns the array of essential-aware extensions
    def essentials
      @essentials ||= {}
    end
    
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