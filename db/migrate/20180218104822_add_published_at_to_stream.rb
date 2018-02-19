class AddPublishedAtToStream < ActiveRecord::Migration[5.1]
  def change
    add_column :streams, :published_at, :datetime
  end
end
