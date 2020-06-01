class CreateWatchersRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :watchers_relationships do |t|
      t.bigint :user_id, null: false
      t.bigint :ticket_id, null: false
      t.timestamps
    end
    add_index :watchers_relationships, :ticket_id
    add_index :watchers_relationships, :user_id
  end
end
