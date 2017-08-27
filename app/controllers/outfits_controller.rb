class OutfitsController < ApplicationController
    before_action :authenticate_user!
    before_action :outfit, :only => [:show, :edit, :update, :destroy]

	def index
		@outfits = current_user.outfits
		@items = current_user.items
	end

	def show
		@items = @outfit.items
		@all_user_items = @current_user.items
	end

	def new
		@outfit = Outfit.new
		if params[:item_id]
			@item_outfit = ItemOutfit.new
		end
		@seasons = current_user.seasons
	end

	def create	
	binding.pry	
		current_user.current_outfit = current_user.outfits.build(outfit_params)
		if !params[:outfit][:item][:item_id].empty?
		    item_outfit = current_user.current_outfit.add_item(params[:outfit][:item][:item_id])
		    item_outfit.save
		end	
		if current_user.current_outfit.save
			redirect_to outfit_path(current_user.current_outfit)
		else
			redirect_to new_outfit_path
		end
	end

	def edit
		@seasons = current_user.seasons
	end

	def update
		@outfit.update(outfit_params)
		if @outfit.save
			redirect_to outfit_path(@outfit)
		else
			redirect_to new_outfit_path
		end
	end

	def destroy
		@outfit.delete
    	redirect_to outfits_path
	end

	private

	def check_user
		if current_user != current_outfit.user
			redirect_to root_path
		end
	end
	
	def outfit
		@outfit = Outfit.find(params[:id])
		if @outfit.user != current_user
			redirect_to outfits_path
		end
	end

	def outfit_params
		params.require(:outfit).permit(:title, :outfit_type, :season_id, :season_attributes => [:title], :item => [:item_id])
	end
end
