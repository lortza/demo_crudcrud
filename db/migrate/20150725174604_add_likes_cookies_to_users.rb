class AddLikesCookiesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :likes_cookies, :boolean, :default => false
  end
end
