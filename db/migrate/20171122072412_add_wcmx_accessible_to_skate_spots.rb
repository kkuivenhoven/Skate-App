class AddWcmxAccessibleToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :wcmx_accessible, :boolean, default: false
  end
end
