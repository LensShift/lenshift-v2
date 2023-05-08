class Fellow::PhotosController < ApplicationController
	before_action :authenticate_fellow!

	def index
		gon.photos = Photo.all
		gon.documents = Document.all
	end

	def create
		photo = Photo.create(photo_params)
		if photo.valid?
			render json: photo, status: :created
		else
			render json: render_errors(photo.errors), status: :unprocessable_entity
		end
	end

	def update
		photo = Photo.find(params[:id])
		if photo.update(photo_params)
			render json: photo, status: :ok
		else
			render json: render_errors(photo.errors), status: :unprocessable_entity
		end
	end

	def destroy
		photo = Photo.find(params[:id])
		return render json: render_errors("Cannot find the photo"), status: :not_found if photo.blank?
		flash[:notice] = "photo deleted"
		photo.destroy

		head :no_content
	end

	private
	
	def render_errors(errors)
		{errors: errors}
	end
	def photo_params
		params.require(:photo).permit(:title, :image, :desc)			
	end
end
