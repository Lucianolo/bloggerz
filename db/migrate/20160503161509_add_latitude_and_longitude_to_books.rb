class AddLatitudeAndLongitudeToBooks < ActiveRecord::Migration
  def change
    add_column :books, :lat, :float
    add_column :books, :lng, :float
  end
end
