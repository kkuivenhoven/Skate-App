class AddStreetToSkateSpot < ActiveRecord::Migration
  def change
    add_column :skate_spots, :street, :string
  end
end
