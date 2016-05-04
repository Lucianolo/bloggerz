class AddLatitudeAndLongitudeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_lat, :float
    add_column :users, :user_lng, :float
  end
end
