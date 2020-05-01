class MoveRoleAtributeFromUsersCompaniesRelationshipToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :integer, null: false, default: 0
    remove_column :users_companies_relationships, :role, :integer
  end
end
