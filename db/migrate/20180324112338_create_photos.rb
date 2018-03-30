class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :image
      t.string :desc

      t.timestamps
    end
  end
end
