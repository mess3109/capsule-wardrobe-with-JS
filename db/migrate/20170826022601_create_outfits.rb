class CreateOutfits < ActiveRecord::Migration[5.1]
  def change
    create_table :outfits do |t|
    	t.integer :season_id
    	t.string :outfit_type
    	t.string :title
    	t.integer :user_id

      	t.timestamps
    end
  end
end
