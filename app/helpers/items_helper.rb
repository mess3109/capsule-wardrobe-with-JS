module ItemsHelper

	def has_outfits?(item)
		!item.outfits.empty?
	end
end
