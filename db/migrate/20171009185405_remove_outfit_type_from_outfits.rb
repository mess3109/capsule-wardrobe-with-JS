class RemoveOutfitTypeFromOutfits < ActiveRecord::Migration[5.1]
  def change
    remove_column :outfits, :outfit_type, :string
  end
end
