require 'test_helper'

class LocationsControllerTest < ActionController::TestCase

  def setup
    @location1 = locations(:one)
    #@location2 = locations(:two)
    @skate_spot = skate_spots(:one)
    #@location1.id = 1
    @user = users(:kendra)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Location.count' do
      post :create, location: @location
    end
    assert_redirected_to login_url
  end

  test "should create when logged in" do
    log_in_as(users(:kendra))
    assert_difference 'Location.count' do
      post :create, location: @location
    end
    assert_redirected_to locations_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Location.count' do
      delete :destroy, id: locations(:one)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for incorrect user" do
    log_in_as(users(:kimberly))
    assert_no_difference 'Location.count' do
      delete :destroy, id: locations(:one)
    end
    assert_redirected_to skate_spots_url
  end

  test "should destroy for correct user" do
    log_in_as(@user)
    before = Location.count
    @location1.id = 1
    assert_equal @skate_spot.user_id,@user.id
    #if @skate_spot.user_id == @user.id
      assert_equal @location1.skate_spot_id,@skate_spot.id
      #if @location1.skate_spot_id == @skate_spot.id
        delete :destroy, id: @skate_spot.location_id
        after = Location.count
        assert_equal after, before-1
        assert_redirected_to skate_spots_path
      #end
    #end
  end

end
