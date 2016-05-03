require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)
  
  test "that creating a friendship works without raising an exception" do
    assert_nothing_raised do
      UserFriendship.create user: users(:lux), friend: users(:lucius)
    end
  end
  
  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:lux).id, friend_id: users(:vitaletti).id
    assert users(:lux).friends.include?(users(:vitaletti))
  end
  
  context "a new instance" do
    setup do
      @user_friendship = UserFriendship.new user: users(:lux), friend: users(:vitaletti)
    end
    
    should "have a pending state" do
      assert_equal "pending", @user_friendship.state
    end
  end
  
  
  #context "#send_request_email" do
  # should "send and email" do
  #    assert_difference 'ActionMailer::Base.deliveries.size', 1 do
  #     
  #      @user_friendship = UserFriendship.create user: users(:lux), friend: users(:vitaletti)
  #     
  #    end
  #  end
  #end
  
  context "#accept" do
    setup do
      
      @user_friendship = UserFriendship.create user: users(:lux), friend: users(:vitaletti)
      
    end
    
    should "set the state to accepted" do
      @user_friendship.accept
      assert_equal "accepted", @user_friendship.state
    end
    
    should "include the friend in the user's friends list" do
      @user_friendship.accept
      puts @user_friendship.state
      users(:lux).friends.reload
      assert users(:lux).friends.include?(:vitaletti)
      
    end
  end
  
end
