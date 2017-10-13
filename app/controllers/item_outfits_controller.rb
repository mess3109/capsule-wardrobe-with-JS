class ItemOutfitsController < ApplicationController

	def create
		current_user.current_outfit = Outfit.find(params[:outfit_id])
		@item_outfit = current_user.current_outfit.add_item(params[:item_id])
		respond_to do |format|
			format.html { redirect_to outfit_path(current_user.current_outfit) }
			format.json { render json: @item_outfit, :include => [:item, :outfit] }
		end
	end

	def destroy
		item_outfit = ItemOutfit.find_by(:item_id => params[:item], :outfit_id => params[:outfit])
		item_outfit.delete
		render body: nil, status: :no_content
		respond_to do |format|
			format.html { redirect_to outfit_path(Outfit.find(params[:outfit])) }
			format.json { render body: nil, status: :no_content }
		end
	end
end
