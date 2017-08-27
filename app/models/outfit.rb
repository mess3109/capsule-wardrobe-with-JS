class Outfit < ApplicationRecord
	has_many :item_outfits
	has_many :items, :through => :item_outfits
	belongs_to :season
	belongs_to :user

	validates :title, :presence => true
	validates :season_id, :presence => true
	validates :outfit_type, :presence => true

	def season_attributes=(season)
		if self.season_id.nil?
		    self.season = Season.find_or_create_by(title: season["title"])
		end
	end

end
