require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
 
  test "should exists user_id " do
    comment=Comment.new
    assert !comment.save
    assert !comment.errors[:user_id].empty?
  end
  
  test "should exists book_id" do
    comment=Comment.new
    assert !comment.save
    assert !comment.errors[:book_id].empty?
  end
  
end
