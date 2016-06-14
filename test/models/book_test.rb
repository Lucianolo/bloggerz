require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    
    test "should user_id" do
      book = Book.new
      assert !book.save
      assert !book.errors[:user_id].empty?
    end
 

    test "should exists isbn" do
      book = Book.new
      assert !book.save
      assert !book.errors[:isbn].empty?
    end

end
