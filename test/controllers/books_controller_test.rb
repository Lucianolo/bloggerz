require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    sign_in users(:lux)
    get :new
    assert_response :success
  end

  test "should create book" do
    sign_in users(:lux)
    assert_difference('Book.count') do
      post :create, book: { isbn: 8845292614 }
    end
  end

  test "should show book" do
    sign_in users(:lux)
    get :show, id: @book
    assert_response :success
  end

  test "should can't edit" do #user cant edit book if isn't owner
    sign_in users(:lux)
    get :edit, id: @book
    assert_redirected_to @book
  end

  test "should update book" do
    sign_in users(:lux)
    put :update, id: @book, book: { content: "MyText" }
    assert_redirected_to book_path(assigns(:book))
  end

  test "should can't destroy book" do #user cant destroy book if isn't owner
    sign_in users(:lux)
    #assert_difference('Book.count') do
      delete :destroy, id: @book
    #end
    
    assert_redirected_to @book
  end
end
