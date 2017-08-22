class AddNeighborhoodSpotSizeToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :neighborhood_spot_size, :boolean
  end
end
