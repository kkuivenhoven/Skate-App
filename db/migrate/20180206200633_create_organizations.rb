class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :category
      t.string :website
      t.string :email
      t.string :phone_num
      t.string :youtube
      t.string :instagram
      t.string :facebook
      t.string :twitter
      t.string :image_logo

      t.timestamps null: false
    end
  end
end
