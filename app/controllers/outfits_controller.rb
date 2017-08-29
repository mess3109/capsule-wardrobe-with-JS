class OutfitsController < ApplicationController
    before_action :authenticate_user!
    before_action :outfit, :only => [:show, :edit, :update, :destroy]
    before_action :check_user, :only => [:show, :edit, :update, :destroy]
    before_action :seasons, :only => [:new, :create, :edit, :update]
    before_action :item_outfit, :only => [:new, :create]

	def index
	end

	def show
	end

	def new
		@outfit = Outfit.new
	end

	def create
		@outfit = current_user.outfits.build(outfit_params)
		if !params[:outfit][:item_outfit][:item_id].empty?
		    @outfit.add_item(params[:outfit][:item_outfit][:item_id])
		end	
		if @outfit.save
			redirect_to outfit_path(@outfit)
		else
			render :new
		end
	end

	def edit
	end

	def update
		@outfit.update(outfit_params)
		if @outfit.save
			redirect_to outfit_path(@outfit)
		else
			render :edit
		end
	end

	def destroy
		@outfit.delete
    	redirect_to outfits_path
	end

	private
	
	def outfit
		@outfit = Outfit.find(params[:id])
	end

	def check_user
		if @outfit.user != current_user
			redirect_to outfits_path
		end
	end

	def seasons
		@seasons = current_user.seasons
	end

	def outfit_params
		params.require(:outfit).permit(:title, :outfit_type, :season_id, :season_attributes => [:title], :item_outfit_attribute => [:item_id])
	end

	def item_outfit
		if params[:item_id]
			@item_outfit = ItemOutfit.new(:item_id => params[:item_id])
		end
	end
end
