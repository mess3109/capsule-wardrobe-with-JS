class Outfit < ApplicationRecord
	has_many :item_outfits
	has_many :seasons

	validates :title, :presence => true
	validates :season_id, :presence => true
	validates :type, :presence => true

end
