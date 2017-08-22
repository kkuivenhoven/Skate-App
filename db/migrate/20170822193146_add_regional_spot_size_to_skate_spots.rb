class AddRegionalSpotSizeToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :regional_spot_size, :boolean
  end
end
