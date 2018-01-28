class AddIndexToSlug < ActiveRecord::Migration[5.1]
  def change
  	add_index :resource_items, :slug
  end
end
