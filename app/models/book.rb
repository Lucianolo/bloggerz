class Book < ActiveRecord::Base
    acts_as_votable
    
    belongs_to :user
    has_many :comments, dependent: :destroy
    
    validates :user_id, presence: true
    
    
    def distance(user_lat, user_lng)
      miles = Geocoder::Calculations.distance_between([self.lat, self.lng],[user_lat, user_lng])
      km = (miles*1.60934).round(2)
    end
end
