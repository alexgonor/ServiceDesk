class RemoveAuthorFromTickets < ActiveRecord::Migration[5.1]
  def change
    remove_column :tickets, :author
  end
end
