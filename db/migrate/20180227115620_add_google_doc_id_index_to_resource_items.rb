class AddGoogleDocIdIndexToResourceItems < ActiveRecord::Migration[5.1]
  def change
  	add_index :resource_items, :google_doc_id
  end
end
