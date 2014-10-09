class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :user_id

      t.timestamps
    end
  end
end
