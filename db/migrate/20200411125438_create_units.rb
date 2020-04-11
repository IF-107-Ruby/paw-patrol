class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :name, null: false
      t.string :qr_link, null: false

      t.timestamps
    end
  end
end
