class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.binary :data
      t.string :filename
      t.string :mime_type

      t.timestamps
    end
  end
end
