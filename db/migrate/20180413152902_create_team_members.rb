class CreateTeamMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :function
      t.string :role
      t.jsonb :info

      t.timestamps
    end
    add_index :team_members, :function
  end
end
