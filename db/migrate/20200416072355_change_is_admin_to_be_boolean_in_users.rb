class ChangeIsAdminToBeBooleanInUsers < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :users, bulk: true do |t|
        dir.up do
          t.remove :is_admin
          t.column :is_admin, :boolean, null: false, default: false
        end

        dir.down do
          t.remove :is_admin
          t.column :is_admin, :integer
        end
      end
    end
  end
end
