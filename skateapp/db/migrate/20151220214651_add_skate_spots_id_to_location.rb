class AddSkateSpotsIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :skate_spots_id, :integer
  end
end
