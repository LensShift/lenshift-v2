class AddImageToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :static_pages, :image, :string
  end
end
