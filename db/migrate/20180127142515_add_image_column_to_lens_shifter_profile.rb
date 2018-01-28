class AddImageColumnToLensShifterProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :lens_shifter_profiles, :image, :string
  end
end
