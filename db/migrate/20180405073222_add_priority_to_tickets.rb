class AddPriorityToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :priority, :integer
  end
end
