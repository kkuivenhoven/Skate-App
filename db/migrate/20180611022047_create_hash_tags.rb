class CreateHashTags < ActiveRecord::Migration
  def change
    create_table :hash_tags do |t|
      t.string :name
      t.text :reply_ids

      t.timestamps null: false
    end
  end
end
