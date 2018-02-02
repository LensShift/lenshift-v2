class AddConfirmableToDevsie < ActiveRecord::Migration[5.1]
  
  def change
  	add_column :lens_shifters, :confirmation_token, :string
    add_column :lens_shifters, :confirmed_at, :datetime
    add_column :lens_shifters, :confirmation_sent_at, :datetime
    add_column :lens_shifters, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :lens_shifters, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # lens_shifters as confirmed, do the following
    LensShifter.all.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end
end
