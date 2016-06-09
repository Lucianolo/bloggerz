class Comment < ActiveRecord::Base
  resourcify
  belongs_to :user
  belongs_to :book
  validates :content, presence: true
end
