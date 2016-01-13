require 'test_helper'

class SkateSpotsControllerTest < ActionController::TestCase

  def setup
    @skate_spot = skate_spots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skate_spots)
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
      post :create, skate_spot: { name: "Humboldt" }
    end
    assert_redirected_to skate_spot_path(assigns(:skate_spot))
  end

  test "should redirect destroy for wrong skate_spot" do
    log_in_as(users(:kimberly))
    assert_no_difference 'SkateSpot.count' do
      delete :destroy, id: skate_spots(:one)
    end
    assert_redirected_to skate_spots_path
  end

  #test "should destroy skate_spot for correct user" do
  #  log_in_as(users(:kendra))
  #  assert_difference('SkateSpot.count') do
  #     post :destroy, id: skate_spots(:one)
  #    #delete :destroy, id: skate_spots(:one)
  #  end
  #end

end
