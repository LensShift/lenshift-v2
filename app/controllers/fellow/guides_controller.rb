class Fellow::GuidesController < ApplicationController
	before_action :authenticate_fellow!
	before_action :set_guide, only: [:edit, :update, :destroy]

	def index
		@guides = Guide.all
	end

	def new
		@guide = Guide.new
	end

	def edit
	end

	def create
	end

	def update
	end

	def destroy
	end

	private

	def set_guide
		@guide = Guide.friendly.find(params[:id])
	end

	def resource_item_params
      params.require(:guides).permit(:title, :description, :file, :image, :tags, :slug, :lens_shifter_id)
  	end
end
