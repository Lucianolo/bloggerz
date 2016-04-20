class ChangeIsbnIntegerLimit < ActiveRecord::Migration
  def change
    remove_column :books, :isbn
    add_column :books, :isbn, :string, limit:10
  end
end
