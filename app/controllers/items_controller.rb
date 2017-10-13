class ItemsController < ApplicationController
	before_action :authenticate_user!
	before_action :current_item, :only => [:show, :edit, :update, :destroy]
	before_action :check_user, :only => [:show, :edit, :update, :destroy]
	before_action :categories, :only => [:new, :create, :edit, :update]

	def index
	end

	def show
		respond_to do |format|
			format.html { render :show }
			format.json { render json: @item.to_json( 
				:only => [:id, :title],
				:include => [:category => { :only => [:id, :title] }]
				)}
		end
	end

	def new
		@item = Item.new
	end

	def create
		@item = current_user.items.build(item_params)
		if @item.save
			redirect_to item_path(@item)
		else
			render :new
		end
	end

	def edit
	end

	def update
		@item.update(item_params)
		if @item.save
			redirect_to item_path(@item)
		else
			render :edit
		end
	end

	def destroy
		@item.delete
		redirect_to items_path
	end

	def used_items
		if params["order"] == "most"
			@most_or_least_used = Item.most_used_items.by_user(current_user).limit(5)
			@most_or_least = "Most"
		elsif params["order"] == "least"
			@most_or_least_used = Item.least_used_items.by_user(current_user).limit(5)
			@most_or_least = "Least"
		else
			redirect_to items_path
		end
		render 'most_used'
	end

	private
	
	def current_item
		@item = Item.find(params[:id])
	end

	def check_user
		if @item.user != current_user
			redirect_to items_path
		end
	end

	def item_params
		params.require(:item).permit(:title, :color, :condition, :brand, :image, :category_id, :category_attributes => [:title])
	end

	def categories
		@categories = current_user.categories
	end

end
