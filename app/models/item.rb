require 'pry'

class Item < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :item_outfits
	has_many :outfits, :through => :item_outfits

	validates :title, :presence => true
	validates :color, :presence => true
	validates :category_id, :presence => true

	def category_attributes=(category)
		if self.category_id.nil?
		    self.category = Category.find_or_create_by(title: category["title"])
		end
	end
end
