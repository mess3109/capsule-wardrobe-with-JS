class ItemOutfitsController < ApplicationController

	def create
	    # if !current_user.current_currentoutfit
	    #   	# current_user.current_cart = Cart.new
	    #   	# current_user.save
	    # end
	    line_item = current_user.current_outfit.add_item(params[:item_id])
	    line_item.save
	    redirect_to outfit_path(current_user.current_outfit)
	end
end
