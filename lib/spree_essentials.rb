require 'spree_core'
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
        
    config.to_prepare do
      #loads application's model / class decorators
      Dir.glob File.expand_path("../../app/**/*_decorator*.rb") do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      #loads application's deface view overrides
      Dir.glob File.expand_path("../../app/overrides/*.rb", __FILE__) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end
      
  end

end
