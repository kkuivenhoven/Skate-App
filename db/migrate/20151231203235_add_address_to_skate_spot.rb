class AddAddressToSkateSpot < ActiveRecord::Migration
  def change
    add_column :skate_spots, :address, :string
  end
end
