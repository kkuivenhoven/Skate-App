require 'test_helper'

class RatingTest < ActiveSupport::TestCase

  def setup
    @user = users(:kendra)
    @rating = @user.ratings.build(difficulty: 4, police: 5, pedestrian: 1, description: "7-stair near sidewalk")
  end
 
  test "should be valid" do
    assert @rating.valid?
  end
 
end
