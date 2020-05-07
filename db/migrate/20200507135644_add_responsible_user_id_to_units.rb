class AddResponsibleUserIdToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :responsible_user_id, :integer
    add_foreign_key :units, :users, column: :responsible_user_id
  end
end
