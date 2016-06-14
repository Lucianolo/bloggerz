class Comment < ActiveRecord::Base
  resourcify
  belongs_to :user
  belongs_to :book
  validates :user_id, :book_id, :content, presence: true
end
