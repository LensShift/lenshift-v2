class AddDescTitleToResource < ActiveRecord::Migration[5.1]
  def change
  	add_column :resource_items, :article_title, :string
  	add_column :resource_items, :article_desc, :text
  end
end
