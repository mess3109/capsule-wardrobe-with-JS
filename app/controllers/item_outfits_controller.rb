class ItemOutfitsController < ApplicationController

	def create
	    # if !current_user.current_currentoutfit
	    #   	# current_user.current_cart = Cart.new
	    #   	# current_user.save
	    # end
	    # item = Item.find(params[:item_id])

	    current_user.current_outfit = Outfit.find(params[:outfit_id])
	    item_outfit = current_user.current_outfit.add_item(params[:item_id])
	    binding.pry
	    item_outfit.save
	    redirect_to outfit_path(current_user.current_outfit)
	end
end
