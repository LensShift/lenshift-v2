class AddPublishedAtToGuides < ActiveRecord::Migration[5.1]
  def change
    add_column :guides, :published_at, :datetime
  end
end
