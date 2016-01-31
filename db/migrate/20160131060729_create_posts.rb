class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :shop
      t.string :name
      t.string :food
      t.string :pickup
      t.string :phonenumber

      t.timestamps null: false
    end
  end
end
