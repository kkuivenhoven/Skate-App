class AddBmxAccessibleToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :bmx_accessible, :boolean, default: false
  end
end
