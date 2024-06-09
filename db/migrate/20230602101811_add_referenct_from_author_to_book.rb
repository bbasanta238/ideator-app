class AddReferenctFromAuthorToBook < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :writer, foreign_key: {to_table: :authors}, null: false
  end
end
