class RemoveItemUrlFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :item_url, :string
  end
end
