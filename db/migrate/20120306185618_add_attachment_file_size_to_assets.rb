class AddAttachmentFileSizeToAssets < ActiveRecord::Migration
  def self.up
    add_column :spree_assets, :attachment_file_size, :integer
  end

  def self.down
    remove_column :spree_assets, :attachment_file_size
  end
end
