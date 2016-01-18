require 'test_helper'

class SkateSpotTest < ActiveSupport::TestCase

  def setup
    @user = users(:kendra)
    @skate_spot = @user.skate_spots.build(name: "Testing", zip_code: "95928", street: "265 Humboldt Ave", city: "Chico", state: "CA", country: "USA")
  end

  test "name should be present" do
    @skate_spot.name = " "
    assert_not @skate_spot.valid?
  end

  test "zip code should be 5 characters" do
    @skate_spot.zip_code = "a"*5
    assert @skate_spot.valid?
  end

  test "country should be 3 characters" do
    @skate_spot.country = "a"*3
    assert @skate_spot.valid?
  end
 
  test "zip code should be present" do
    @skate_spot.zip_code = " "
    assert_not @skate_spot.valid?
  end
 
  test "street should be present" do
    @skate_spot.street = " "
    assert_not @skate_spot.valid?
  end

  test "city should be present" do
    @skate_spot.city = " "
    assert_not @skate_spot.valid?
  end

  test "country should be present" do
    @skate_spot.country = " "
    assert_not @skate_spot.valid?
  end

end
