class AddAccessTokenToCompany < ActiveRecord::Migration[6.0]
  def change
    change_table :companies, bulk: true do |t|
      t.column :access_token, :string
      t.column :enable_access_token, :boolean, default: false
    end
  end
end
