class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :skate_spot  
 
  #filter_language :description, matchlist: :hate, replacement: :garbled
  # validate_language :username, matchlist: :profanity

end
