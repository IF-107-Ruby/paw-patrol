class RemoveIndexInFeedbacks < ActiveRecord::Migration[6.0]
  def change
    remove_index :feedbacks, name: 'index_feedbacks_on_email'
  end
end
