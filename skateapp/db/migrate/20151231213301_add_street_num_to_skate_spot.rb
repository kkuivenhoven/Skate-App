class AddStreetNumToSkateSpot < ActiveRecord::Migration
  def change
    add_column :skate_spots, :street_num, :integer
  end
end
