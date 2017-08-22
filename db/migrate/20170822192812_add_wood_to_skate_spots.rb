class AddWoodToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :wood, :boolean
  end
end
