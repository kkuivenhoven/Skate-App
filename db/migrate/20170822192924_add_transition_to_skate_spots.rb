class AddTransitionToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :transition, :boolean
  end
end
