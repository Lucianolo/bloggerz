class RemoveAvatarThumbColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avatar_thumb
  end
end
