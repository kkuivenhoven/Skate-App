class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :skate_spot  
end
