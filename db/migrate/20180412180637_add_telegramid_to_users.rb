class AddTelegramidToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :telegram_id, :string
    add_column :users, :bot_command_data, :jsonb, default: {}
  end
end
