class AddDisabledAtToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :disabled_at, :datetime
  end
end
