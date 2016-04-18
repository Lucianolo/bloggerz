require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  
  context "#new" do 
    context "when not logged in" do
      should "redirect to the login page" do
        get :new
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
    
    context "when logged in" do
      setup do
        sign_in users(:lux)
      end
      
      should "get new and return success" do
        get :new
        assert_response :success
      end
      
      should "set a flash error if the friend_id params is missing" do
        get :new, {}
        assert_equal "Friend required", flash[:error]
      end
      
      should "display the friend's name" do
        get :new, friend_id: users(:vitaletti)
        assert_match /#{users(:vitaletti).full_name}/, response.body
      end
      
      should "assign a new user friendship" do 
        get :new, friend_id: users(:vitaletti)
        assert assigns(:user_friendship)
      end
      
      should "assign a friendship to the correct friend" do 
        get :new, friend_id: users(:vitaletti)
        assert_equal assigns(:user_friendship).friend, users(:vitaletti)
      end
      
      should "assign a new user friendship to the currently logged in user" do
        get :new, friend_id: users(:vitaletti)
        assert_equal assigns(:user_friendship).user, users(:lux)
      end
      
      should "return 404 status if no friend is found" do
        get :new, friend_id: "invalid"
        assert_response :not_found
      end
      
      should "ask if you really want to request the friendship" do
         get :new, friend_id: users(:vitaletti)
         assert_match /Do you really want to ask #{users(:vitaletti).full_name} for friendship?/, response.body
      end
      
      
     end
  end
  
  context "#create" do
    context "when not logged in" do
      should "redirect to the login page" do
        get :new 
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
    
    context "when logged in " do
      setup do
        sign_in users(:lux)
      end
      
      context "with no friend_id" do 
        setup do
          post :create
        end
        
        should "set the flash error message" do
          assert !flash[:error].empty?
        end
        
        should "redirect to the site root" do
          assert_redirected_to root_path
        end
      end
      
      context "with a valid friend_id" do
        setup do
          post :create, user_friendship: { friend_id: users(:vitaletti) }
        end
        
        should "assign a friend object" do
          assert assigns(:friend)
          assert_equal users(:vitaletti), assigns(:friend)
        end
        
        should "assign a user_friendship object" do
          assert assigns(:user_friendship)
          assert_equal users(:lux), assigns(:user_friendship).user
          assert_equal users(:vitaletti), assigns(:user_friendship).friend
        end
        
        should "create a friendship" do
          assert users(:lux).friends.include?(users(:vitaletti))
        end
        
        should "redirect to the profile page of the friend" do
          assert_response :redirect
          assert_redirected_to profile_path(users(:vitaletti))
        end
        
        should "set the flash success message" do
          assert flash[:success]
          assert_equal "You are now friends with #{users(:vitaletti).full_name}", flash[:success]
        end
      end
      
    end
  end
end
