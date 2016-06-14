require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase

#validates :user_id, :friend_id,

  test "should exists user_id" do
    user_friend = UserFriendship.new
    assert !user_friend.save
    assert !user_friend.errors[:user_id].empty?
  end
  
  test "should exists friend_id" do
    user_friend = UserFriendship.new
    assert !user_friend.save
    assert !user_friend.errors[:friend_id].empty?
  end

end
