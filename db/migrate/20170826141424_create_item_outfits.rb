class CreateItemOutfits < ActiveRecord::Migration[5.1]
  def change
    create_table :item_outfits do |t|
    	t.integer :outfit_id
    	t.integer :item_id
    	t.integer :user_id

      	t.timestamps
    end
  end
end
