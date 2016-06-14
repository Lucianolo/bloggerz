require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:lux)
  end
  
  
  test "should get show" do
    sign_in users(:lux)
    get :show, id: users(:lux).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end
  
  test "should render a 404 on profile not found" do
    sign_in users(:lux)
    get :show, id: "none"
    assert_response :not_found
    #assert_match "The page you were looking for doesn't exist", response.body
  end
  
  test "that variables are assigned on succesful profile viewing" do
    sign_in users(:lux)
    get :show, id: users(:lux).profile_name
    assert assigns(:user)
  end
  
end
