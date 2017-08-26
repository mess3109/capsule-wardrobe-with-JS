class OutfitsController < ApplicationController
    before_action :authenticate_user!
    before_action :current_outfit, :only => [:show, :edit, :update, :destroy]

	def index
		@outfits = current_user.outfits

	end

	def show
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
	end

	def update
	end

	def destroy
		@outfit.delete
    	redirect_to outfits_path
	end

	private
	
	def current_outfit
		@outfit = Outfit.find(params[:id])
	end

	def outfit_params
		params.require(:outfit).permit()
	end
end
