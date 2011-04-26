require 'generators/essentials_base'

module SpreeEssentials
  module Generators
    class InstallGenerator < SpreeEssentials::Generators::EssentialsBase
      
      desc "Installs required migrations for spree_essentials"
      source_root File.expand_path("../../templates/db/migrate", __FILE__)
      
      def copy_migrations
        migration_template "add_attachment_file_size_to_assets.rb", "db/migrate/add_attachment_file_size_to_assets.rb"
      end

    end
  end
end