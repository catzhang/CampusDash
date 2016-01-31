class AddShopaddrToPost < ActiveRecord::Migration
  def change
    add_column :posts, :shopaddr, :string
  end
end
