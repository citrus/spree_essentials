module SpreeEssentials
  module Generators
    class EssentialsBase < Rails::Generators::Base
    
      include Rails::Generators::Migration      

      def self.count
        @count ||= 0
        (@count += 1) * 3
      end
      
      def self.new_migration_number
        (Time.new.utc + self.count).strftime("%Y%m%d%H%M%S")
      end

      def self.next_migration_number(path)
        @time ||= Time.new.utc
        if ActiveRecord::Base.timestamped_migrations
          files = Dir.entries(Rails.root.join("db/migrate"))
          migration = new_migration_number
          while files.join.include?(migration)
            migration = new_migration_number
          end
          migration
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      
    end
  end
end
