class ItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :current_item, :only => [:show, :edit, :update, :destroy]

	def index
		@items = current_user.items
	end

	def show
	end

	def new
		@item = Item.new
		@categories = current_user.categories
	end

	def create
		@item = current_user.items.build(item_params)
		if @item.save
			redirect_to item_path(@item)
		else
			redirect_to new_item_path
		end
	end

	def edit
		@categories = current_user.categories
	end

	def update
		@item.update(item_params)
		if @item.save
			redirect_to item_path(@item)
		else
			redirect_to new_item_path
		end
	end

	def destroy
		@item.delete
    	redirect_to items_path
	end

	private
	
	def current_item
		@item = Item.find(params[:id])
		if current_user != @item.user
			redirect_to root_path
		end
	end

	def item_params
		params.require(:item).permit(:title, :color, :condition, :image_url, :category_id, :category_attributes => [:title])
	end

end
