class Item < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :item_outfits
	has_many :outfits, :through => :item_outfits
end
