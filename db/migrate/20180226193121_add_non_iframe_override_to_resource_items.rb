class AddNonIframeOverrideToResourceItems < ActiveRecord::Migration[5.1]
  def change
    add_column :resource_items, :no_iframe, :boolean, default: false
  end
end
