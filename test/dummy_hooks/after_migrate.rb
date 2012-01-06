run "rails g spree_essentials:install"
rake "db:migrate", :env => "test"

# Creates sample data in development database
# rake "db:migrate db:seed db:sample:cms", :env => "development"
