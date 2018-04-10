class AddImageBooleanToStaticPage < ActiveRecord::Migration[5.1]
  def change
    add_column :static_pages, :show_image, :boolean, default: true
  end
end
