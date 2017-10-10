class ItemOutfitsController < ApplicationController

	def create
	    current_user.current_outfit = Outfit.find(params[:outfit_id])
	    item_outfit = current_user.current_outfit.add_item(params[:item_id])
		render json: item_outfit, status: 201
	end

	def destroy
		item_outfit = ItemOutfit.find_by(:item_id => params[:item], :outfit_id => params[:outfit])
		item_outfit.delete
		redirect_to outfit_path(Outfit.find(params[:outfit]))
	end
end
