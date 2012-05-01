class AddAttachmentFileSizeToAssets < ActiveRecord::Migration
  def self.up
    add_column :spree_assets, :attachment_file_size, :integer unless column_exists?(:spree_assets, :attachment_file_size)
  end

  def self.down
    remove_column :spree_assets, :attachment_file_size if column_exists?(:spree_assets, :attachment_file_size)
  end
end
