class AddGatedToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :gated, :boolean
  end
end
