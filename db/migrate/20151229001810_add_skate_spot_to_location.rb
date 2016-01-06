class AddSkateSpotToLocation < ActiveRecord::Migration
  def change
    add_reference :locations, :skate_spot, index: true, foreign_key: true
  end
end
