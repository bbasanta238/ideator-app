class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :persons do |t|
      t.string :name
      t.string :surname
      t.numeric :phone_number
      t.integer :gender
      t.timestamps
    end
  end
end
