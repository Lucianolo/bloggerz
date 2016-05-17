class AddColumnToSwap < ActiveRecord::Migration
  def change
    add_column :swaps, :other_book_id, :integer
  end
end
