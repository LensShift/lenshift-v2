class Fellow::BlogsController < ApplicationController
	before_action :authenticate_fellow!
	before_action :set_blog, only: [:edit, :update, :destroy]

	def index
		@blogs = Blog.all
	end

	def new
	end

	def edit
	end

	def update
		return render json: @blog, errors: "You can't. You didn't create the blog", status: :unprocessable_entity if @blog.lens_shifter != current_lens_shifter

		if @blog.update_attributes(blog_params)
			# flash[:notice] = "Well done!, you have updated the blog"
			render json: @blog, status: :ok
		else
			render json: render_errors(@blog.errors), status: :unprocessable_entity
		end

	end

	def create
		blog = current_lens_shifter.blogs.create(blog_params)
		if blog.valid?
			render json: blog, status: :created
		else
			render json: render_errors(blog.errors), status: :unprocessable_entity
		end
	end

	def destroy

		if @blog.lens_shifter != current_lens_shifter
			flash[:notice] = "You can't. You didn't create the blog"
		else
			@blog.destroy
		end

		redirect_to fellow_blogs_path
	end

	private

	def blog_params
		params.require(:blog).permit(:title, :content, :published_at, :tags, :tag_list, :lens_shift_id, :slug)
	end

	def set_blog
		@blog = Blog.friendly.find(params[:id])
		return render_not_found if @blog.blank?

		rescue ActiveRecord::RecordNotFound
			return render_not_found
	end

	def render_errors(errors)
		{errors: errors}
	end

	def render_not_found(status=:not_found)
		render :index, text: "#{status.to_s.titleize}", status: status
	end

end
