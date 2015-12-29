class AddSkateSpotsIdToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :skate_spots_id, :integer
  end
end
