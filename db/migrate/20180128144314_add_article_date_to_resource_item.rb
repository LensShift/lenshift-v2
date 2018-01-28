class AddArticleDateToResourceItem < ActiveRecord::Migration[5.1]
  def change
    add_column :resource_items, :article_date, :datetime
  end
end
