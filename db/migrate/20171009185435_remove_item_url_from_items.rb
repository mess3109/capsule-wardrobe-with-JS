class RemoveItemUrlFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :image_url, :string
  end
end
