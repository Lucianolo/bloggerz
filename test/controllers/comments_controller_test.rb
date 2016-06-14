require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  
  test "should create comment" do
      sign_in users(:lux)
      assert_difference('books(:one).comments.count') do
          post :create, comment: { content: "ciao" }, book_id: books(:one)  
      end
      
  end
  
  test "should destroy comment" do
      sign_in users(:lux)
      @comment = books(:one).comments.build(content: "ciao")
      @comment.user_id= users(:lux).id
      
      @comment.save!
      assert_difference('books(:one).comments.count', -1) do
          delete :destroy, id: @comment, book_id: books(:one)  
      end
  end
      
end
