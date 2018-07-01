class AddEventIdsToHashTags < ActiveRecord::Migration
  def change
    add_column :hash_tags, :event_ids, :text
  end
end
