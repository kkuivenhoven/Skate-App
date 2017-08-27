class AddDownVoteToSkateSpots < ActiveRecord::Migration
  def change
    add_column :skate_spots, :down_vote, :integer, :null => false, :default => 0
  end
end
