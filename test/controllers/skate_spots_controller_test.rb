require 'test_helper'

class SkateSpotsControllerTest < ActionController::TestCase

  def setup
    @skate_spot = skate_spots(:one)
#    @skate_spot2 = skate_spots(:two)
    @user = users(:kendra)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skate_spots)
  end
  
  test "should get show and flash for correct user" do
    log_in_as(@user)
    get :show, id: @skate_spot
    assert_response :success
    assert_equal 'Location incorrect? Please delete this spot and create a new street spot.', flash[:warning]
  end
  
  test "should get show" do
    get :show, id: @skate_spot
    assert_response :success
  end
  
  test "should redirect new for non-logged in user" do
    get :new
    assert_redirected_to login_path
  end

  test "should get new for logged in user" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'SkateSpot.count' do
      post :create, skate_spot: { name: "Humboldt" }
    end
    assert_redirected_to login_url  
  end
 
  test "should create a skate spot when logged in" do
    log_in_as(users(:kendra))
    assert_difference('SkateSpot.count')do
      post :create, skate_spot: { name: "Humboldt", street: "265 Humboldt Ave", city: "Chico", zip_code: "92928", state: "CA", country: "USA" }
    end
    assert_not flash.empty?
    assert_equal 'Creation successful!', flash[:success]
    assert_redirected_to skate_spot_path(assigns(:skate_spot))
  end

  test "should redirect destroy skate_spot when not logged in" do
    assert_no_difference 'SkateSpot.count' do
      delete :destroy, id: skate_spots(:one)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy skate_spot for incorrect user" do
    log_in_as(users(:kimberly))
    assert_no_difference 'SkateSpot.count' do
      delete :destroy, id: skate_spots(:one)
    end
    assert_redirected_to skate_spots_path
  end

  test "should destroy skate_spot for correct user" do
    log_in_as(@user)
    before = SkateSpot.count
    if @skate_spot.user_id == @user.id
      delete :destroy, id: @skate_spot
      after = SkateSpot.count
      assert_equal after, before-1
      assert_not flash.empty?
      assert_equal 'Deletion successful!', flash[:success]
      assert_redirected_to skate_spots_path
    end
  end

end
