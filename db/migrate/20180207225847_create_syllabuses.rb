class CreateSyllabuses < ActiveRecord::Migration[5.1]
  def change
    create_table :syllabuses do |t|
      t.integer :row_order
      t.references :lesson, foreign_key: true
      t.references :resource_item, foreign_key: true

      t.timestamps
    end
  end
end
