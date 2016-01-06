class AddZipCodeToSkateSpot < ActiveRecord::Migration
  def change
    add_column :skate_spots, :zip_code, :string
  end
end
