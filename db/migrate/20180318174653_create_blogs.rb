class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
    	t.string :title
    	t.text :content
    	t.string :slug
      	t.references :lens_shifter, foreign_key: true
      	t.string :tags
      	t.datetime :published_at

      t.timestamps
    end
  end
end
