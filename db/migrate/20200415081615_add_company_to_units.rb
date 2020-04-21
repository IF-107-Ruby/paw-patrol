class AddCompanyToUnits < ActiveRecord::Migration[6.0]
  def change
    add_reference :units, :company, foreign_key: true
  end
end
