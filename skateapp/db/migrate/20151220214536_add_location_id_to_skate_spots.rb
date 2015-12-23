class AddLocationIdToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :location_id, :integer
  end
end
