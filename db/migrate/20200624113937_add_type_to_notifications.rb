class AddTypeToNotifications < ActiveRecord::Migration[6.0]
  class Notifications < ApplicationRecord
    enum exemplar: { unspecified: 0, new_comment: 1 }
  end

  def change
    reversible do |dir|
      dir.up do
        add_column :notifications, :exemplar, :integer, default: 0
        Notifications.all.update(exemplar: :new_comment)
      end
      dir.down do
        remove_column :notifications, :exemplar
      end
    end
  end
end
