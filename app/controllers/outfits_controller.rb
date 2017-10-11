class OutfitsController < ApplicationController
	before_action :authenticate_user!
	before_action :outfit, :only => [:show, :edit, :update, :destroy, :items_not_used]
	before_action :check_user, :only => [:show, :edit, :update, :destroy]
	before_action :seasons, :only => [:new, :create, :edit, :update]
	before_action :item_outfit, :only => [:new, :create]

	def index
		@outfits = current_user.outfits.sort_by { |outfit| outfit.season.title }
		respond_to do |format|
			format.html { render :index }
			format.json { render json: @outfits}
		end
	end

	def show
		respond_to do |format|
			format.html { render :show }
			format.json { render json: @outfit}
		end
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

	def items_not_used
		@items = (current_user.items - @outfit.items).sort_by { |item| item.category.title }
		render json: @items
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
		params.require(:outfit).permit(:title, :season_id, :season_attributes => [:title], :item_outfit_attribute => [:item_id])
	end

	def item_outfit
		if params[:item_id]
			@item_outfit = ItemOutfit.new(:item_id => params[:item_id])
		end
	end
end
