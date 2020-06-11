class AddConfirmableToDevise < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
    end
    add_index :users, :confirmation_token, unique: true
  end
end
