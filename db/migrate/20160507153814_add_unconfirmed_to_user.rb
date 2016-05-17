class AddUnconfirmedToUser < ActiveRecord::Migration
  def change
    add_column :users, :other_book_id, :integer
  end
end
