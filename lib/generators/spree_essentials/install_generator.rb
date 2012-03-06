module SpreeEssentials
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      desc "Installs required migrations for spree_essentials"
      source_root File.expand_path("../../templates/db/migrate", __FILE__)
      
      def copy_migrations
        rake "spree_essentials:install:migrations"
      end

    end
  end
end
