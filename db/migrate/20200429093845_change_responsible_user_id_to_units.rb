class ChangeResponsibleUserIdToUnits < ActiveRecord::Migration[6.0]
  def change
    add_reference :units, :user, foreign_key: true
  end
end
