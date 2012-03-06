module SpreeEssentials
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      desc "Installs required migrations for spree_essentials"
      
      def copy_migrations
        rake "spree_essentials:install:migrations"
      end

    end
  end
end
