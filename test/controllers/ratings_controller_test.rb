require 'test_helper'

class RatingsControllerTest < ActionController::TestCase

  setup do
    @rating1 = ratings(:one)
    @rating2 = ratings(:two)
    @rating3 = ratings(:three)
    @skate_spot = skate_spots(:one)
  end

#  test "should redirect destroy for wrong rating post" do
#    log_in_as(users(:kimberly))
#    get 'skate_spot'
#    assert_no_difference 'Rating.count' do
#     delete :destroy, id: ratings(:one)
#    end
#    assert_redirected_to skate_spot_path(@skate_spot)
#  end


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
