class OutfitsController < ApplicationController
    before_action :authenticate_user!
    before_action :outfit, :only => [:show, :edit, :update, :destroy]

	def index
		@outfits = current_user.outfits
		@items = current_user.items
	end

	def show
		@items = current_outfit.items
	end

	def new
		@outfit = Outfit.new
		@seasons = current_user.seasons
	end

	def create
		@outfit = current_user.outfits.build(outfit_params)
		if @outfit.save
			redirect_to outfit_path(@outfit)
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
		if current_user != @outfit.user
			redirect_to root_path
		end
	end

	def outfit_params
		params.require(:outfit).permit(:title, :outfit_type, :season_id, :season_attributes => [:title])
	end
end
