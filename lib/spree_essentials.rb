require 'spree_core'
require 'spree_auth'

require 'rdiscount'
require 'meta_search' 
require 'acts-as-taggable-on'

module SpreeEssentials
  
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "static assets" do |app|
      app.middleware.insert_before ::Rack::Lock, ::ActionDispatch::Static, "#{config.root}/public"
    end

  end
  
  class CustomHooks < Spree::ThemeSupport::HookListener

    # public    
    #insert_after :footer_left,  'hooks/footer_left'
    #insert_after :footer_right,  'hooks/footer_right'
    #insert_after :signup_below_password_fields, 'hooks/signup_checkbox'

    # admin
    insert_after :admin_tabs,   'admin/shared/contents_tab'

  end
  
end