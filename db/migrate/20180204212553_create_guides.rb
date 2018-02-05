class CreateGuides < ActiveRecord::Migration[5.1]
  def change
    create_table :guides do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :file
      t.references :lens_shifter, foreign_key: true

      t.timestamps
    end
  end
end
