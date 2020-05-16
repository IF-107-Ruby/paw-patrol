class CreateRecurringEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :recurring_events do |t|
      t.string :title, null: false
      t.datetime :anchor, null: false
      t.integer :duration, null: false, default: 24 * 60
      t.integer :frequency, null: false, default: 0
      t.string :color, null: false, default: '#0000ff', limit: 9
      t.integer :ticket_id
      t.integer :user_id
      t.integer :unit_id, null: false

      t.timestamps
    end
    add_foreign_key :recurring_events, :tickets, column: :ticket_id
    add_foreign_key :recurring_events, :users, column: :user_id
    add_foreign_key :recurring_events, :units, column: :unit_id
  end
end
