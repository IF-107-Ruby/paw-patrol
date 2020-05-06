class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.string :ancestry
      
      t.timestamps
    end
    add_index :comments, :ancestry
  end
end
