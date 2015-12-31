class AddCrossStreetToSkateSpot < ActiveRecord::Migration
  def change
    add_column :skate_spots, :cross_street, :string
  end
end
