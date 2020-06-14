class AddAccessTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :access_token
      t.boolean :access_token_enabled
    end

    add_index :users, :access_token
  end
end
