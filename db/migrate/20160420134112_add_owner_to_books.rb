class AddOwnerToBooks < ActiveRecord::Migration
  def change
    add_index :books, :user_id
  end
end
