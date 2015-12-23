class AddNameToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :name, :string
  end
end
