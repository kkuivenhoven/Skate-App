class AddSkateSpotSizeToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :skate_spot_size, :boolean
  end
end
