class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  validates :content, presence: true
end
