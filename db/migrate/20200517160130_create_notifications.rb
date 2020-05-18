class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :noticeable_id, null: false
      t.string :noticeable_type, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :notified_by_id, null: false
      t.boolean :read, null: false, default: false

      t.timestamps
    end
    add_foreign_key :notifications, :users, column: :notified_by_id
  end
end
