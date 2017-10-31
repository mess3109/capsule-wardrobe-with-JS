class Item < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :item_outfits
	has_many :outfits, :through => :item_outfits

	validates :title, :presence => true
	validates :color, :presence => true
	validates :category_id, :presence => true

	has_attached_file :image, default_url: ':style/default.png' 
		# styles => {
		# 	:thumb => "100x100#",
		# 	:small  => "150x150>",
		# 	:medium => "200x200" 
		# }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	def category_attributes=(category)
		if self.category_id.nil?
			self.category = Category.find_or_create_by(title: category["title"])
		end
	end

	scope :most_used_items, -> {
		select("*, count(item_outfits.id) AS outfits_count").
		left_joins(:item_outfits).
		group("items.id").
		order("outfits_count DESC") 
	}

	scope :least_used_items, -> {
		select("*, count(item_outfits.id) AS outfits_count").
		left_joins(:item_outfits).
		group("items.id").
		order("outfits_count ASC") 
	}

	def self.by_user(user)
		where(:user_id => user.id)
	end

	def outfits_sorted_by_season
		self.outfits.sort_by { |outfit| outfit.season.title }
	end

end
