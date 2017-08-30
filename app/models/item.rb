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

	scope :most_used_items, -> {
    select("*, count(item_outfits.id) AS outfits_count").
    left_joins(:item_outfits).
    group("items.id").
    order("outfits_count DESC") }

  	def self.by_user(user)
		where(:user_id => user.id)
  	end
  	
  	def outfits_sorted_by_season
  		self.outfits.sort_by { |outfit| outfit.season.title }
  	end
 
end
