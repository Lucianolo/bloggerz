class Swap < ActiveRecord::Base
    belongs_to :user
    belongs_to :other, class_name: 'User', foreign_key: 'other_id'
end
