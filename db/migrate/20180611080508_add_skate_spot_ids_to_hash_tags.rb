class AddSkateSpotIdsToHashTags < ActiveRecord::Migration
  def change
    add_column :hash_tags, :skate_spot_ids, :text
  end
end
