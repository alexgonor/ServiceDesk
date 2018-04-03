class ChangeExecutorToBeStringInTickets < ActiveRecord::Migration[5.1]
  def change
    change_column :tickets, :executor, :string
  end
end
