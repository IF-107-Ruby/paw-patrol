class AddDefaultValueForRoleToUsersCompaniesRelationship < ActiveRecord::Migration[6.0]
  def change
    change_column :users_companies_relationships, :role, :integer,
                  null: false, default: 0
  end
end
