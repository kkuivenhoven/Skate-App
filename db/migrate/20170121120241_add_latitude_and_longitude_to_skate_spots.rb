class AddLatitudeAndLongitudeToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :latitude, :float
    add_column :skate_spots, :longitude, :float
  end
end
