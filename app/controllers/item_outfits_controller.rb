class ItemOutfitsController < ApplicationController

	def create
		current_user.current_outfit = Outfit.find(params[:outfit_id])
		@item_outfit = current_user.current_outfit.add_item(params[:item_id])
		render json: @item_outfit.to_json(
		 :include => [:item, :outfit] 
		 )
	end

	def destroy
		item_outfit = ItemOutfit.find_by(:item_id => params[:item], :outfit_id => params[:outfit])
		item_outfit.delete
		render body: nil, status: :no_content
	end
end
