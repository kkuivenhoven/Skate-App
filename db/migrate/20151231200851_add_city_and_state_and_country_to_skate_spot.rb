class AddCityAndStateAndCountryToSkateSpot < ActiveRecord::Migration
  def change
    add_column :skate_spots, :city, :string
    add_column :skate_spots, :state, :string
    add_column :skate_spots, :country, :string
  end
end
