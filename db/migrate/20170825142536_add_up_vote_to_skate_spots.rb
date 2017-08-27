class AddUpVoteToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :up_vote, :integer, :null => false, :default => 0
  end
end
