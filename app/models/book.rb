class Book < ActiveRecord::Base
    resourcify
    acts_as_votable
    
    belongs_to :user
    has_many :comments, dependent: :destroy
    
    validates :user_id, :isbn , presence: true
    
    
    def distance(user_lat, user_lng)
      miles = Geocoder::Calculations.distance_between([self.lat, self.lng],[user_lat, user_lng])
      km = (miles*1.60934).round(2)
    end
    
    def is_swapped
      Swap.where(book_id: self.id, status:"accepted").first or Swap.where(other_book_id: self.id, status: "accepted").first
    end
    
    def swaps_count
      count = Swap.where(book_id: self.id, status:"accepted").count + Swap.where(other_book_id: self.id, status: "accepted").count
    end
end
