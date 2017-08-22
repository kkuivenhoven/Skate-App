class AddStreetPlazaToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :street_plaza, :boolean
  end
end
