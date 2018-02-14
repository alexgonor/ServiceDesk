class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.integer :status
      t.integer :type
      t.string :title
      t.text :detailed_description
      t.integer :responsible_unit
      t.integer :author
      t.integer :executor
      t.date :deadline
      t.text :history
      t.string :attachment

      t.timestamps
    end
  end
end
