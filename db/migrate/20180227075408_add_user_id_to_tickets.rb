class AddUserIdToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :user_id, :integer, null: false
    add_index :tickets, :user_id
  end
end
