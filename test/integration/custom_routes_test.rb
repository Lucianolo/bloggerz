require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
  
  test "that the /login route opens the login page" do
    get '/login'
    assert_response :success
  end  
  
  test "that the /logout route opens the login page" do
    get '/logout'
    assert_response :redirect
    assert_redirected_to '/'
  end  
  
  test "that the /register route opens the login page" do
    get '/register'
    assert_response :success
  end 
  
  test "that a profile page displays correctly" do
    get '/Lux_Luthor'
    assert_response :success
  end
end
