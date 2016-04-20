class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :isbn
      t.integer :user_id
      t.string :author
      t.string :title
      t.string :cover_uri
      t.text :description
      t.timestamps null: false
    end
  end
  
  
end
