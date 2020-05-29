class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :comment, null: false
      t.references :ticket, null: false,
                            foreign_key: true,
                            index: { unique: true }

      t.timestamps
    end
  end
end
