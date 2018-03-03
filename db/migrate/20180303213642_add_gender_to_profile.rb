class AddGenderToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :gender, :string
    change_column_default :profiles, :contact_consent, true
  end
end
