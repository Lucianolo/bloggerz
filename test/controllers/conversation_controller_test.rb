require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase
  
  setup do
      sign_in users(:lux)
  end
  
  test "Should get index" do
      get :index
      assert_response :success
  end
  
  test "Should create a conversation" do
      get :create , { sender_id: users(:lux), recipient_id: users(:lucius) } do
          assert_difference("Conversations.count")
      end
      
  end
end
