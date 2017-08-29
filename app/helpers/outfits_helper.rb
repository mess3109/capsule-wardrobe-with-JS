module OutfitsHelper

	def has_items?(outfit)
		!outfit.items.empty?
	end
end
