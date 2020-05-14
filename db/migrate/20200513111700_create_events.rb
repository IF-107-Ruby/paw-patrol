class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :color
      t.integer :ticket_id
      t.integer :user_id
      t.integer :unit_id

      t.timestamps
    end

    add_foreign_key :events, :tickets, column: :ticket_id
    add_foreign_key :events, :users, column: :user_id
    add_foreign_key :events, :units, column: :unit_id
  end
end
