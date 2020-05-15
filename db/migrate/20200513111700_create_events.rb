class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.string :color, null: false, default: '#0000ff'
      t.integer :ticket_id
      t.integer :user_id
      t.integer :unit_id, null: false

      t.timestamps
    end

    add_foreign_key :events, :tickets, column: :ticket_id
    add_foreign_key :events, :users, column: :user_id
    add_foreign_key :events, :units, column: :unit_id
  end
end
