class CreatePostTaggings < ActiveRecord::Migration
  def change
    create_table :post_taggings do |t|
      t.integer :tag_id
      t.integer :post_id

      t.timestamps
    end

    add_index :post_taggings, [:tag_id, :post_id], :unique => true
  end
end
