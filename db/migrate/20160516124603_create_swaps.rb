class CreateSwaps < ActiveRecord::Migration
  def change
    create_table :swaps do |t|
      t.integer :user_id
      t.integer :other_id
      t.integer :book_id
      t.string :status
      t.timestamps null: false
    end
  end
end
