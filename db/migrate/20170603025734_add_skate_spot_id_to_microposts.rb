class AddSkateSpotIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :skate_spot_id, :integer
  end
end
