class AddLocationToSkateSpot < ActiveRecord::Migration
  def change
    add_reference :skate_spots, :location, index: true, foreign_key: true
  end
end
