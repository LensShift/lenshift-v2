class CreateStaticPages < ActiveRecord::Migration[5.1]
  def change
    create_table :static_pages do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.references :lens_shifter, foreign_key: true

      t.timestamps
    end
  end
end
