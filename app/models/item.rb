class Item < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :item_outfits
	has_many :outfits, :through => :item_outfits

	validates :title, :presence => true
	validates :color, :presence => true
	validates :category_id, :presence => true
end
