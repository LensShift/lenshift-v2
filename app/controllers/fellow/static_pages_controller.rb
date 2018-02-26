class Fellow::StaticPagesController < ApplicationController
	before_action :authenticate_fellow!
	before_action :set_page, only: [:edit, :update, :destroy]

	def index
		@pages = StaticPage.all
	end

	def edit
		gon.page = @page
	end

	def update
		if @page.update_attributes(satic_page_params)
			redirect_to @page, notice: 'Page was successfully updated'
		else
			flash[:warning] = "There is a problem updating"
			render @page
		end
	end

	def new
		@page = StaticPage.new
	end

	def create
		@page = current_lens_shifter.static_pages.create(static_page_params)
		if @page.valid?
			flash[:notice] = 'Page was successfully created.'
			redirect_to static_page_path(@page), status: :created
		else
			render json: render_errors(@page.errors), status: :unprocessable_entity
		end
	end

	def delete
		return render json: render_errors("Cannot find the stream"), status: :not_found if @page.blank?
    	return render json: render_errors("you can't"), status: :forbidden if @page.lens_shifter != current_lens_shifter
    
    
   		@page.destroy
   		redirect_to fellow_static_pages
	end

	private

	def static_page_params
		params.require(:static_page).permit(:title, :content)
	end

	def set_page
		@page = StaticPage.friendly.find(params[:id])
	end

	def render_errors(errors)
      { errors: errors }
    end
end
