class AddAttachmentFileSizeToAssets < ActiveRecord::Migration
  def self.up
    rename_column :assets, :attachment_size, :attachment_file_size unless Asset.column_names.include?("attachment_file_size")
  end

  def self.down
    rename_column :assets, :attachment_file_size, :attachment_size unless Asset.column_names.include?("attachment_size")
  end
end
