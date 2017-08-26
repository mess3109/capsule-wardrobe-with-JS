class Outfit < ApplicationRecord
	has_many :item_outfits

	validates :title, :presence => true
	validates :season_id, :presence => true
	validates :type, :presence => true

end
