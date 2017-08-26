class Outfit < ApplicationRecord
	has_many :item_outfits
	has_many :items, :through => :item_outfits
	belongs_to :season
	belongs_to :user

	validates :title, :presence => true
	validates :season_id, :presence => true
	validates :outfit_type, :presence => true

end
