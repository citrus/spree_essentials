# install spree and migrate db
#run "bundle exec rails g spree:sandbox"

rake "spree:install:migrations"

insert_into_file File.join('config', 'routes.rb'), :after => "Application.routes.draw do\n" do
  "  # Mount Spree's routes\n  mount Spree::Core::Engine, :at => '/'\n"
end

run "bundle exec rails g spree_essentials:install"

copy_file "test.pdf", "public/test.pdf"
copy_file "test.zip", "public/test.zip"

# remove all stylesheets except core  
%w(admin store).each do |ns|
  js  = "app/assets/javascripts/#{ns}/all.js"
  css = "app/assets/stylesheets/#{ns}/all.css"
  remove_file js
  remove_file css
  template "#{ns}/all.js", js
  template "#{ns}/all.css", css
end
