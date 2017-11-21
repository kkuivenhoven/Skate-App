class AddUserVotesToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :user_votes, :text
  end
end
