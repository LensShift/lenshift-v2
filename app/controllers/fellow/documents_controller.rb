class Fellow::DocumentsController < ApplicationController
	before_action :authenticate_fellow!

	def index
		gon.documents = Document.all
	end

	def create
		document = Document.create(document_params)
		if document.valid?
			render json: document, status: :created
		else
			render json: render_errors(document.errors), status: :unprocessable_entity
		end
	end

	def update
		document = Document.find(params[:id])
		if document.update_attributes(document_params)
			render json: document, status: :success
		else
			render json: render_errors(document.errors), status: :unprocessable_entity
		end
	end

	def destroy
		document = Document.find(params[:id])
		return render json: render_errors("Cannot find the document"), status: :not_found if document.blank?
		flash[:notice] = "document deleted"
		document.destroy

		head :no_content
	end

	private
	
	def render_errors(errors)
		{errors: errors}
	end
	def document_params
		params.require(:document).permit(:title, :file, :desc)			
	end
end
