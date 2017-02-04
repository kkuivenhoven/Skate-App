class AddNumberToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :number, :integer
  end
end
