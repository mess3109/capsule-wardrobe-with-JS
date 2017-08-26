class Season < ApplicationRecord
	has_many :outfits

	validates :title, :presence => true, :uniqueness => true
end
