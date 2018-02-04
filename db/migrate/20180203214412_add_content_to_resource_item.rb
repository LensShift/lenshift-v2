class AddContentToResourceItem < ActiveRecord::Migration[5.1]
  def change
    add_column :resource_items, :article_content, :text
  end
end
