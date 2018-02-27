class AddUserIdToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :user_id, :integer
  end
end
