class AddStreetSpotToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :street_spot, :boolean
  end
end
