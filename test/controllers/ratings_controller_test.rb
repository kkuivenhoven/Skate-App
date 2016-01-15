#Sources: 
#http://stackoverflow.com/questions/1451135/rails-how-to-modify-tests-for-a-nested-resource

require 'test_helper'

class RatingsControllerTest < ActionController::TestCase

  def setup
    @rating1 = ratings(:one)
    @skate_spot = skate_spots(:one)
    @user1 = users(:kendra)
    @user2 = users(:kimberly)
  end

  test "should redirect create when not logged in" do
     assert_no_difference 'Rating.count' do
       post :create, skate_spot_id: 1, rating: @rating1
     end
     assert_redirected_to login_url
   end

#  test "should create a rating when logged in" do
#     log_in_as(@user1)
#     assert_difference 'Rating.count' do
#       post :create, skate_spot_id: 1, rating: @rating1
#     end
#     assert_redirected_to skate_spot_path(@skate_spot)
#   end
  
  test "should redirect destroy rating when not logged in" do
     assert_no_difference 'Rating.count' do
       delete :destroy, skate_spot_id: 1, id: ratings(:one)
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
     assert_redirected_to skate_spot_path(@skate_spot)
  end

  #test "should get index" do
  #  get :index
  #  assert_response :success
  #  assert_not_nil assigns(:ratings)
  #end

  #test "should get new" do
  #  get :new
  #  assert_response :success
  #end

  #test "should create rating" do
  #  assert_difference('Rating.count') do
  #    post :create, rating: { description: @rating.description, difficulty: @rating.difficulty, pedestrian: @rating.pedestrian, police: @rating.police, time: @rating.time }
  #  end

  #  assert_redirected_to rating_path(assigns(:rating))
  #end

  #test "should show rating" do
  #  get :show, id: @rating
  ##  assert_response :success
  #end

  #test "should get edit" do
  #  get :edit, id: @rating
   # assert_response :success
  #end

  #test "should update rating" do
  #  patch :update, id: @rating, rating: { description: @rating.description, difficulty: @rating.difficulty, pedestrian: @rating.pedestrian, police: @rating.police, time: @rating.time }
  #  assert_redirected_to rating_path(assigns(:rating))
  #end

  #test "should destroy rating" do
  #  assert_difference('Rating.count', -1) do
   #   delete :destroy, id: @rating
   # end

   # assert_redirected_to ratings_path
  #end
end
