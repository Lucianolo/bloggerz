require 'test_helper'


class ManagerControllerTest < ActionController::TestCase
  
  
  test "should upgrade user" do
      sign_in users(:lux)
      sign_in users(:lucius)
      
      post :upgrade, id: users(:lucius)
      
      assert_redirected_to books_path
  end
  
  test "should downgrade user" do
      sign_in users(:lux)
      sign_in users(:lucius)
      
      post :downgrade, id: users(:lucius)
      
      assert_redirected_to books_path
  end
  
end
