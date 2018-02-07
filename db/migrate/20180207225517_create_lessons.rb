class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :analysis
      t.references :stream, foreign_key: true
      t.integer :row_order

      t.timestamps
    end
  end
end
