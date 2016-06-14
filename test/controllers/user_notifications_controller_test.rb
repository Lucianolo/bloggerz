require 'test_helper'



class UserNotificationsControllerTest < ActionController::TestCase

  
  test "should get index" do
    sign_in users(:lux)
    get :index
    assert_response :success
  end
  
end
