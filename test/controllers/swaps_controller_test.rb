require 'test_helper'

class SwapsControllerTest < ActionController::TestCase
  
  test "should create a swap" do
    sign_in users(:lux)
    post :create, book_id: books(:one),  other_book_id: books(:two)
    assert redirect_to root_path
    
  end
  
  test "should accept a swap" do
    sign_in users(:lux)
    get :accept, id: swaps(:one)
    assert redirect_to root_path
  end
  
  test "should declin a swap" do
    sign_in users(:lux)
    get :decline, id: swaps(:one)
    assert redirect_to root_path
  end
end
