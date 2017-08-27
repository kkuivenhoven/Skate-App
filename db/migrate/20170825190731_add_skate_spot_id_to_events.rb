class AddSkateSpotIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :skate_spot_id, :integer
  end
end
