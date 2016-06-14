require 'test_helper'

class SwapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  
  #validates :user_id, :other_id, :book_id
  test "should exists user_id" do
    swap= Swap.new
    assert !swap.save
    assert !swap.errors[:user_id].empty?
  end
  
  test "should exists other_id" do
    swap= Swap.new
    assert !swap.save
    assert !swap.errors[:other_id].empty?
  end
  
  test "should exists book_id" do
    swap= Swap.new
    assert !swap.save
    assert !swap.errors[:book_id].empty?
  end
  
end
