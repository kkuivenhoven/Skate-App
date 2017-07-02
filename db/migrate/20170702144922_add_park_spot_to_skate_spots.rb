class AddParkSpotToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :park_spot, :boolean
  end
end
