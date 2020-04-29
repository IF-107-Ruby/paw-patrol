class RenameDescribeToMessageInFeedbacks < ActiveRecord::Migration[6.0]
  def change
    rename_column :feedbacks, :describe, :message
  end
end
