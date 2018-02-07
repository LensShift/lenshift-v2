class CreateStreams < ActiveRecord::Migration[5.1]
  def change
    create_table :streams do |t|
      t.string :title
      t.text :description
      t.integer :estimated_reading_time
      t.text :guiding_questions
      t.string :tags
      t.string :slug
      t.string :image
      t.references :lens_shifter, foreign_key: true

      t.timestamps
    end
  end
end
