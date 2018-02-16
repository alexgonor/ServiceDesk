class ChangeColumnsName < ActiveRecord::Migration[5.1]
  def change
  rename_column :tickets, :type, :type_of_ticket
  rename_column :tickets, :status, :status_of_ticket
  end
end
