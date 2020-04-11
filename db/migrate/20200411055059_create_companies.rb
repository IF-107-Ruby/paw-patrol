class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.text :description
      t.string :email, null: false
      t.string :phone

      t.timestamps
    end
  end
end
