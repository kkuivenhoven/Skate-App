#Sources: 
#http://stackoverflow.com/questions/1451135/rails-how-to-modify-tests-for-a-nested-resource

require 'test_helper'

class RatingsControllerTest < ActionController::TestCase

  def setup
    @rating1 = ratings(:one)
    @skate_spot = skate_spots(:one)
    @user1 = users(:kendra)
    @user2 = users(:kimberly)

    @rating2 = @skate_spot.ratings.build(police: 1, description: "10-stair", pedestrian: 1, difficulty: 1)
  end

  test "should redirect new when not logged in" do
     get :new, skate_spot_id: 1
     assert_redirected_to login_path 
  end

  test "should get new when logged in" do
     log_in_as(@user1)
     get :new, skate_spot_id: 1
     assert_response :success
  end

  test "should redirect create when not logged in" do
     assert_no_difference 'Rating.count' do
       post :create, skate_spot_id: 1, rating: @rating1
     end
     assert_redirected_to login_url
   end

#  test "should create a rating when logged in" do
#     log_in_as(@user1)
#     #assert_difference 'Rating.count' do
#     #  post :create, skate_spot_id: 1, id: @rating1
#     #end
#     assert_redirected_to skate_spot_path(@skate_spot)
#   end

  test "should redirect edit when not logged in" do
    get :edit, skate_spot_id: 1, id: ratings(:one)
    assert_redirected_to login_url
  end
  
  test "should redirect destroy rating when not logged in" do
     assert_no_difference 'Rating.count' do
       delete :destroy, skate_spot_id: 1, id: ratings(:one)
     end
     assert_redirected_to login_url
  end
  
  test "should redirect update rating when not logged in" do
     assert_no_difference 'Rating.count' do
       patch :update, skate_spot_id: 1, id: ratings(:one)
     end
     assert_redirected_to login_url
  end
  
  test "should redirect destroy rating when incorrect user" do
     log_in_as(@user2)
     assert_no_difference('Rating.count', 0) do
       delete :destroy, skate_spot_id: 1, id: ratings(:one)
     end
     assert_redirected_to skate_spot_path(@skate_spot)
  end
  
  test "should destroy rating when correct user" do
     log_in_as(@user1)
     before = Rating.count
     assert_equal @user1.id, @rating1.user_id
       delete :destroy, skate_spot_id: 1, id: @rating1
       after = Rating.count
       assert_equal after, before-1
     assert_not flash.empty?
     assert_redirected_to skate_spot_path(@skate_spot)
  end

end
