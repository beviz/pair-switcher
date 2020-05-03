class AddNameToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :name, :string
    Team.where(name: nil).update_all(name: 'my team')
  end
end
