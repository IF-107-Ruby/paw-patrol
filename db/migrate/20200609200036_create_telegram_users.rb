class CreateTelegramUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :telegram_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :language_code
      t.integer :user_id
      t.string :link_token
      t.datetime :linked_at

      t.timestamps
    end

    add_index :telegram_users, :user_id
    add_foreign_key :telegram_users, :users, column: :user_id
  end
end
