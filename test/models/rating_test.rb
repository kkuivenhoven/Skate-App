require 'test_helper'

class RatingTest < ActiveSupport::TestCase

  def setup
    @user = users(:kendra)
    @rating = @user.ratings.build(difficulty: 4, police: 5, pedestrian: 1, description: "7-stair near sidewalk")
  end
 
  test "should be valid" do
    assert @rating.valid?
  end
 
  test "description should be present" do
    @rating.description = "   "
    assert_not @rating.valid?
  end
  
  test "description should be at least 4 characters long" do
    @rating.description = "a"*2
    assert_not @rating.valid?
  end
 
  test "difficulty should be integer" do
    @rating.difficulty = "lkj" 
    assert_not @rating.valid?
  end

  test "difficulty should be greater than or equal to 0" do
    @rating.difficulty = -1
    assert_not @rating.valid?
  end

  test "police should be less than or equal to 10" do
    @rating.police = 11
    assert_not @rating.valid?
  end

  test "police should be greater than or equal to 0" do
    @rating.police = -1
    assert_not @rating.valid?
  end

  test "police should be integer" do
    @rating.police = "lkj" 
    assert_not @rating.valid?
  end

  test "pedestrian should be less than or equal to 10" do
    @rating.pedestrian = 11
    assert_not @rating.valid?
  end

  test "pedestrian should be greater than or equal to 0" do
    @rating.pedestrian = -1
    assert_not @rating.valid?
  end

  test "pedestrian should be integer" do
    @rating.pedestrian = "lkj" 
    assert_not @rating.valid?
  end

end
