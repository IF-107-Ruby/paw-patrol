class ChangeResponsibleUserIdToUnits < ActiveRecord::Migration[6.0]
  def change
    remove_column :units, :responsible_user_id, :boolean, :index

    add_reference :units, :user, foreign_key: true
  end
end
