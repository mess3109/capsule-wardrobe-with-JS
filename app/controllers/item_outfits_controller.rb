class ItemOutfitsController < ApplicationController

	def create
	    current_user.current_outfit = Outfit.find(params[:outfit_id])
	    item_outfit = current_user.current_outfit.add_item(params[:item_id])
	    item_outfit.save
	    redirect_to outfit_path(current_user.current_outfit)
	end
end
