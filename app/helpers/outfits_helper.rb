module OutfitsHelper

	def has_items?(outfit)
		!outfit.items.empty?
	end

	def items_not_in_outfit(outfit)
		(current_user.items - outfit.items).sort_by { |item| item.category.title }
	end

end
