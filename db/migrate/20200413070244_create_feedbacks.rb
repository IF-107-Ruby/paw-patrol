class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.string :user_full_name
      t.string :email
      t.text :describe

      t.timestamps
    end
  end
end
