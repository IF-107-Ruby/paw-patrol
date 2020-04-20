class CreateUsersCompaniesRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :users_companies_relationships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end

    add_index :users_companies_relationships,
              %i[user_id company_id],
              unique: true,
              name: :relationship_index
  end
end
