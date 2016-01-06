class AddSkateSpotToRating < ActiveRecord::Migration
  def change
    add_reference :ratings, :skate_spot, index: true, foreign_key: true
  end
end
