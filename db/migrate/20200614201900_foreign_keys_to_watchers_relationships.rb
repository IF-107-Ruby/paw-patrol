class ForeignKeysToWatchersRelationships < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :watchers_relationships, :users, column: :user_id
    add_foreign_key :watchers_relationships, :tickets, column: :ticket_id
  end
end
