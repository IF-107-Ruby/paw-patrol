class AddStateToTelegramProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :telegram_profiles, :state, :integer, null: false, default: 0
  end
end
