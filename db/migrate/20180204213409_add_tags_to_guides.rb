class AddTagsToGuides < ActiveRecord::Migration[5.1]
  def change
    add_column :guides, :tags, :string
    add_column :guides, :slug, :string
  end
end
