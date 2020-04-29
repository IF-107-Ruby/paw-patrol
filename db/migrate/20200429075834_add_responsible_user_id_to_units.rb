class AddResponsibleUserIdToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :responsible_user_id, :boolean
    add_index :units, :responsible_user_id
  end
end
