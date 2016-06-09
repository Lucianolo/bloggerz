class Swap < ActiveRecord::Base
    resourcify
    belongs_to :user
    belongs_to :other, class_name: 'User', foreign_key: 'other_id'
end
