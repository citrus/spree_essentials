class CreateSpreeExamples < ActiveRecord::Migration
  def up
    create_table :spree_examples do |t|
      t.string :title
      t.string :body
    end
  end

  def down
    drop_table :spree_examples
  end
end
