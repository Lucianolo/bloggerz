class AddThumbAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :thumb_avatar, :string
  end
end
