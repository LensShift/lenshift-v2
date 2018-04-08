class BlogsController < ApplicationController

	def index
		@page_title = 'Blogs'
      	@page_description = 'LensShift blog, learn about the inner workings of the organisation'
      	@page_keywords = 'Resource, Library, International Development, Social Impact, Blogs'
		@blogs = Blog.published_before(Time.zone.now)
	end

	def show
		@blog = Blog.friendly.find(params[:id])

		return render_not_found if @blog.blank?
		@page_title = @blog.title
	    @page_description = truncate(@blog.content, length: 140)
	    
	  	if request.path != blog_path(@blog)
	      redirect_to @blog, status: :moved_permanently
	    end

		rescue ActiveRecord::RecordNotFound
			return render_not_found
	end

	private

	def render_not_found(status=:not_found)
		render :index, text: "#{status.to_s.titleize}", status: status
	end

end
