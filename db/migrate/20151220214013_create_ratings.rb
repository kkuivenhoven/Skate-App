class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :difficulty
      t.integer :police
      t.integer :pedestrian
      t.string :time
      t.string :description

      t.timestamps null: false
    end
  end
end
