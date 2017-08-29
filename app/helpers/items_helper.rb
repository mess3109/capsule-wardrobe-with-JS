module ItemsHelper


	def included_in_outfits?(item)
		!item.outfits.empty?
	end
end
