class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :phone
      t.string :school
      t.string :password

      t.timestamps null: false
    end
  end
end
