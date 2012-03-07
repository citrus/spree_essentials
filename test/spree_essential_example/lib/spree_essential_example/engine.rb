module SpreeEssentialExample
  class Engine < Rails::Engine

    engine_name "spree_essential_example"

    config.autoload_paths += %W(#{config.root}/lib)
    
    config.to_prepare do

      Dir.glob File.expand_path("../../app/**/*_decorator.rb", __FILE__) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Dir.glob File.expand_path("../../app/overrides/*.rb", __FILE__) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      
    end
    
  end
end
