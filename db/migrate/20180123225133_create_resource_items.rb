class CreateResourceItems < ActiveRecord::Migration[5.1]
  def change
    create_table :resource_items do |t|
	  t.string :title
      t.string :author
      t.string :source_url
      t.integer :estimated_reading_time
      t.text :short_summary
      t.string :tags
      t.text :key_takeaways
      t.text :analysis_content
      t.string :image
      t.string :resource_type
      t.string :slug
      t.datetime :published_at
      t.boolean :feature
      t.integer :google_doc_id
      t.references :lens_shifter, foreign_key: true

      t.timestamps
    end
  end
end
