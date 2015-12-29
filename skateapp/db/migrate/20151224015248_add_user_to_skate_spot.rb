class AddUserToSkateSpot < ActiveRecord::Migration
  def change
    add_reference :skate_spots, :user, index: true, foreign_key: true
  end
end
