class AddAdminToLensShifter < ActiveRecord::Migration[5.1]
  def change
    add_column :lens_shifters, :admin, :boolean
    add_index :lens_shifters, :admin
  end
end
