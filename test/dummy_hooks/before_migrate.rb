# Require spree_essential_example and spree_atuh in config/application.rb
gsub_file "config/application.rb", 'require "spree_essentials"', %(require "spree_essentials"
require "spree_essential_example")

# Install spree's migrations
rake "spree:install:migrations"

# Copy spree user initializer
template "initializers/spree_user.rb", "config/initializers/spree_user.rb"

# Mount the Spree::Core routes
insert_into_file File.join('config', 'routes.rb'), :after => "Application.routes.draw do\n" do
  "  # Mount Spree's routes\n  mount Spree::Core::Engine, :at => '/'\n"
end

# remove all stylesheets except core
%w(admin store).each do |ns|
  template "#{ns}/all.js",  "app/assets/javascripts/#{ns}/all.js",  :force => true
  template "#{ns}/all.css", "app/assets/stylesheets/#{ns}/all.css", :force => true
end

# Fix sass load error by using the converted css file
template "store/screen.css", "app/assets/stylesheets/store/screen.css"

# Enable forgery_protection since we need AUTH_TOKEN to be defined to avoid JS errors
gsub_file "config/environments/test.rb", "forgery_protection    = false", "forgery_protection = true"

# Install spree essentials & example extension
run "bundle exec rails g spree_essentials:install"
run "bundle exec rails g spree_essentials:example"
