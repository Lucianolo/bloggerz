class ChangeIsbnIntegerLimit2 < ActiveRecord::Migration
  def change
    remove_column :books, :isbn
    add_column :books, :isbn, :string, limit:15
  end
end
