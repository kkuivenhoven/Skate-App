class AddMetalToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :metal, :boolean
  end
end
