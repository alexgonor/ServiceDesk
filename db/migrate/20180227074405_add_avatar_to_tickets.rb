class AddAvatarToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :avatar, :string
  end
end
