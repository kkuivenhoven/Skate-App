class AddRatingIdsToHashTags < ActiveRecord::Migration
  def change
    add_column :hash_tags, :rating_ids, :text
  end
end
