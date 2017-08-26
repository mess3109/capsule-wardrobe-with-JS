class CreateOutfits < ActiveRecord::Migration[5.1]
  def change
    create_table :outfits do |t|

      t.timestamps
    end
  end
end
