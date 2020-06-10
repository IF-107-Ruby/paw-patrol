class RemoveQrLinkFromUnits < ActiveRecord::Migration[6.0]
  def change
    remove_column :units, :qr_link, :string
  end
end
