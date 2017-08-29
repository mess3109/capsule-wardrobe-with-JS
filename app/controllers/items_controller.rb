class ItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :current_item, :only => [:show, :edit, :update, :destroy]
    before_action :categories, :only => [:new, :create, :edit, :update]

	def index
	end

	def show
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

	def most_used
		render 'most_used'
	end

	private
	
	def current_item
		@item = Item.find(params[:id])
		if @item.user != current_user
			redirect_to items_path
		end
	end

	def item_params
		params.require(:item).permit(:title, :color, :condition, :image_url, :category_id, :category_attributes => [:title])
	end

	def categories
		@categories = current_user.categories
	end

end
