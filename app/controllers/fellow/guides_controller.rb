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
		@guide = Guide.create(guide_params)

	    respond_to do |format|
	    if @guide.valid?
	        format.html { redirect_to @guide, notice: 'Guide was successfully created.' }
	        
	        RestClient.patch("https://lensshift-drive.firebaseio.com/guides/#{@guide.id}.json", @guide.to_json)
	        format.json { render :show, status: :created, location: @guide }
	      else
	        format.html { render :new }
	        format.json { render json: @guide.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def update
		respond_to do |format|
	      if @guide.update(guide_params)
	        format.html { redirect_to @guide, notice: 'Guide was successfully updated.' }
	        RestClient.patch("https://lensshift-drive.firebaseio.com/guides/#{@guide.id}.json", @guide.to_json)
	        format.json { render :show, status: :ok, location: @guide }
	      else
	        format.html { render :doc }
	        format.json { render json: @guide.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
		RestClient.patch("https://lensshift-drive.firebaseio.com/guides_deleted/#{guide.id}.json", @guide.to_json)
		RestClient.delete("https://lensshift-drive.firebaseio.com/guides/#{@guide.id}.json")
		@@guide.destroy
		respond_to do |format|
	      format.html { redirect_to fellow_guides_url, notice: 'Guide was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	end

	private

	def set_guide
		@guide = Guide.friendly.find(params[:id])
	end

	def guide_params
      params.require(:guides).permit(:title, :description, :file, :image, :tags, :slug, :lens_shifter_id, :published_at)
  	end
end
