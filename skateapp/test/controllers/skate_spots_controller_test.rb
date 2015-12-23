require 'test_helper'

class SkateSpotsControllerTest < ActionController::TestCase
  setup do
    @skate_spot = skate_spots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skate_spots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skate_spot" do
    assert_difference('SkateSpot.count') do
      post :create, skate_spot: {  }
    end

    assert_redirected_to skate_spot_path(assigns(:skate_spot))
  end

  test "should show skate_spot" do
    get :show, id: @skate_spot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @skate_spot
    assert_response :success
  end

  test "should update skate_spot" do
    patch :update, id: @skate_spot, skate_spot: {  }
    assert_redirected_to skate_spot_path(assigns(:skate_spot))
  end

  test "should destroy skate_spot" do
    assert_difference('SkateSpot.count', -1) do
      delete :destroy, id: @skate_spot
    end

    assert_redirected_to skate_spots_path
  end
end
