module SpreeEssentials
  module Generators
    class ExampleGenerator < Rails::Generators::Base
      
      desc "Installs required migrations for spree_essential_example"
      
      def copy_migrations
        rake "spree_essential_example:install:migrations"
      end
      
    end
  end
end
