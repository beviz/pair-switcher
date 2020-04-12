class AddTeamIdToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :team_id, :integer, index: true
  end
end
