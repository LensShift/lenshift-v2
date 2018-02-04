class AddLocationDetailsToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :address, :jsonb
    add_index :profiles, "(address->'country')", using: :gin, name: 'index_profiles_on_address_city'
  end
end
