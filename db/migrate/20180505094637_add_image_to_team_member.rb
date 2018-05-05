class AddImageToTeamMember < ActiveRecord::Migration[5.1]
  def change
    add_column :team_members, :avatar, :string
  end
end
