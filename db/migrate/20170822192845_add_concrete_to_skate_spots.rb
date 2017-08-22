class AddConcreteToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :concrete, :boolean
  end
end
