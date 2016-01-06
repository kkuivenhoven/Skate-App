class AddRatingToSkateSpot < ActiveRecord::Migration
  def change
    add_reference :skate_spots, :rating, index: true, foreign_key: true
  end
end
