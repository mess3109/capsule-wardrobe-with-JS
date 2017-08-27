class ItemOutfit < ApplicationRecord
	belongs_to :item
	belongs_to :outfit
	belongs_to :user
end
