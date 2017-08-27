class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
    	t.integer :category_id
    	t.integer :user_id
    	t.string :image_url
    	t.string :title
    	t.string :color
      t.string :condition

      t.timestamps
    end
  end
end
