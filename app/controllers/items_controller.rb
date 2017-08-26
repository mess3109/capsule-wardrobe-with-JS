class ItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :current_item, :only =>[:show, :edit, :update, :destroy]

	def index
		@items = current_user.items
	end

	def show
	end

	def new
		@item = Item.new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	
	def current_item
		@item = Item.find(params[:id])
	end

end
