class RemoveThumbAvatarFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :thumb_avatar
  end
end
