class DropLensShifterProfile < ActiveRecord::Migration[5.1]
  def change
  	drop_table :lens_shifter_profiles
  end
end
