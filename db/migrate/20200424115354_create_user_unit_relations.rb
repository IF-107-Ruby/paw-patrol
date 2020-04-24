class CreateUserUnitRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :users_units_relationships do |t|
      t.references :users_companies_relationship, index: { name: :us_co_rel }, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end

    add_index :users_units_relationships,
              %i[users_companies_relationship_id unit_id],
              unique: true,
              name: :user_unit_relation_index
  end
end
