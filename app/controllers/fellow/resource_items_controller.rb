class Fellow::ResourceItemsController < ApplicationController
	before_action :authenticate_fellow!
	before_action :set_resource_item, only: [:edit, :update, :destroy]
	require 'google_drive'
	require 'archieml'

	def index
		@resource_items = ReourceItem.all
	end

	def export_csv
		@resource_items = ResourceItem.all

		respond_to do |format|
			format.csv { send_data @resource_items.to_csv, filename: "resource-items-#{Date.today}.csv"}
		end
	end

	def import_google
		session = GoogleDrive::Session.from_service_account_key("./config/LensShift-Drive-9e638265ad1d.json")
		
		@files = session.files
	end

	def import_csv
		ResourceItem.import_csv(params[:file])
		flash[:notice] = 'File has been imported'
		redirect_to fellow_resource_items_path
	end

	def doc
		session = GoogleDrive::Session.from_service_account_key("./config/LensShift-Drive-9e638265ad1d.json")
    	@resource_item = ResourceItem.new

    	@file = session.file_by_id(params[:file_id])
    	@text_file = @file.export_as_string('text/plain')
    	@parsed_file = Archieml.load(@file.export_as_string('text/plain'))
    	@article = ArticleCrawler.new(@parsed_file['Link'])
	end

	def new
		@resource_item = ResourceItem.new
	end

	  # GET /resource_items/1/edit
	def edit
	end

	  # POST /resource_items
	  # POST /resource_items.json
	def create
	    @resource_item = ResourceItem.create(resource_item_params)

	    respond_to do |format|
	      if @resource_item.valid?
	        format.html { redirect_to @resource_item, notice: 'Resource item was successfully created.' }
	        format.json { render :show, status: :created, location: @resource_item }
	      else
	        format.html { render :new }
	        format.json { render json: @resource_item.errors, status: :unprocessable_entity }
	      end
	    end
	end

	  # PATCH/PUT /resource_items/1
	  # PATCH/PUT /resource_items/1.json
	def update
	    respond_to do |format|
	      if @resource_item.update(resource_item_params)
	        format.html { redirect_to @resource_item, notice: 'Resource item was successfully updated.' }
	        format.json { render :show, status: :ok, location: @resource_item }
	      else
	        format.html { render :edit }
	        format.json { render json: @resource_item.errors, status: :unprocessable_entity }
	      end
	    end
	end

	  # DELETE /resource_items/1
	  # DELETE /resource_items/1.json
	def destroy
		@resource_item.destroy
	    respond_to do |format|
	      format.html { redirect_to resource_items_url, notice: 'Resource item was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	end

	private
 	
 	# Use callbacks to share common setup or constraints between actions.
    def set_resource_item
      @resource_item = ResourceItem.friendly.find(params[:id])
    end

	# Never trust parameters from the scary internet, only allow the white list through.
    def resource_item_params
      params.require(:resource_item).permit(:title, :author, :source_url, :estimated_reading_time, 
      	:short_summary, :tags, :analysis_content, :key_takeaways, :image, :resource_type, :lens_shifter_id, 
      	:google_doc_id, :published_at, :slug, :tag_list, :file_id, :remote_image_url, :feature)
    end
end
