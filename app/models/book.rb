class Book < ActiveRecord::Base
    acts_as_votable
    
    belongs_to :user
    has_many :comments, dependent: :destroy
    
    validates :user_id, presence: true
end
