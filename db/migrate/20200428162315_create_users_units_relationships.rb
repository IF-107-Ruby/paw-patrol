class CreateUsersUnitsRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :users_units_relationships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      
      t.timestamps
    end
    add_index :users_units_relationships,
              %i[user_id unit_id],
              unique: true,
              name: :index_users_units_rel
  end
end
