class AddSkateSpotToUser < ActiveRecord::Migration
  def change
    add_reference :users, :skate_spot, index: true, foreign_key: true
  end
end
