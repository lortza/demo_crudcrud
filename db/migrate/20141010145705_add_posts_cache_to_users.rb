class AddPostsCacheToUsers < ActiveRecord::Migration
  def change
    add_column :users, :posts_cache, :integer, :default => 0, :null => false
  end
end
