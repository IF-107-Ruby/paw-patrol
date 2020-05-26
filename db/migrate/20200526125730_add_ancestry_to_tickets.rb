class AddAncestryToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :ancestry, :string
    add_index :tickets, :ancestry
  end
end
