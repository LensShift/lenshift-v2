class AddVideoEmbedToResourceItem < ActiveRecord::Migration[5.1]
  def change
    add_column :resource_items, :video_embed, :text
  end
end
