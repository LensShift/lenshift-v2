class CreateLensShifterProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :lens_shifter_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :birthdate
      t.string :ethnicity
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :sector
      t.text :referral
      t.text :comment
      t.boolean :contact_consent
      t.string :image
      t.belongs_to :lens_shifter, foreign_key: true

      t.timestamps
    end
  end
end
