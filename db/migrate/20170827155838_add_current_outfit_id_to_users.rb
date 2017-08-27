class AddCurrentOutfitIdToUsers < ActiveRecord::Migration[5.1]
  def change
  	  add_column :users, :current_outfit_id, :integer
  end
end
