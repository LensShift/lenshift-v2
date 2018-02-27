class Fellow::ResourceItemsController < ApplicationController
	before_action :authenticate_fellow!
	before_action :set_resource_item, only: [:edit, :update, :destroy]
	require 'google_drive'
	require 'archieml'


	def index
		@resource_items = ResourceItem.select(:id, :title, :published_at, :lens_shifter_id, :feature, :google_doc_id, :slug).order(:google_doc_id)
	end

	def export_csv
		@resource_items = ResourceItem.all

		respond_to do |format|
			format.csv { send_data @resource_items.to_csv, filename: "resource-items-#{Date.today}.csv"}
		end
	end

	def import_google
		session = GoogleDrive::Session.from_service_account_key(StringIO.new(ENV['GD_SECRETS']))

		@files = session.files.sort_by {|x| x.title}
	end

	def import_csv
		ResourceItem.import_csv(params[:file])
		flash[:notice] = 'File has been imported'
		redirect_to fellow_resource_items_path
	end

	def doc
		session = GoogleDrive::Session.from_service_account_key(StringIO.new(ENV['GD_SECRETS']))
    	@resource_item = ResourceItem.new

    	@file = session.file_by_id(params[:file_id])
    	@parsed_file = Archieml.load(@file.export_as_string('text/plain'))
		gon.parsed_file = @parsed_file
    	
    	begin
    		@article = ArticleCrawler.new(@parsed_file['link']) if !@parsed_file['link'].nil?
    	rescue StandardError
    		flash[:notice] = 'Scraper cannot scrape the link'
    	end
    	
	end

	def new
		@resource_item = ResourceItem.new
		gon.resource_item = @resource_item
	end

	  # GET /resource_items/1/edit
	def edit
		gon.resource_item = @resource_item
	end

	def get_article
		resource_item = ResourceItem.friendly.find(params[:resource_item_id])
		begin
			article = ArticleCrawler.new(resource_item.source_url)
			render json: {title: article.title, description: article.description, content: article.content }
		rescue StandardError
			flash[:notice] = 'Scraper cannot scrape the link'
			render json: { notice: 'Scraper cannot scrape the link', status: :unprocessable_entity }
		end
	end

	  # POST /resource_items
	  # POST /resource_items.json
	def create
		if ResourceItem.exists?(google_doc_id: params[:resource_item]['google_doc_id'])
			respond_to do |format|
				format.html {redirect_to import_google_fellow_resource_items_path, notice: 'Resource existed'}
			end
		else
	    	@resource_item = ResourceItem.create(resource_item_params)
	    	gon.resource_item = @resource_item

		    respond_to do |format|
		    if @resource_item.valid?
		        format.html { redirect_to @resource_item, notice: 'Resource item was successfully created.' }
		        
		        RestClient.patch("https://lensshift-drive.firebaseio.com/resources/#{@resource_item.google_doc_id}.json", @resource_item.to_json)
		        format.json { render :show, status: :created, location: @resource_item }
		      else
		        format.html { render :new }
		        format.json { render json: @resource_item.errors, status: :unprocessable_entity }
		      end
		    end
		end
	end

	  # PATCH/PUT /resource_items/1
	  # PATCH/PUT /resource_items/1.json
	def update
		# @article = ArticleCrawler.new(resource_item_params['source_url']) if !resource_item_params['source_url'].nil?
	    respond_to do |format|
	      if @resource_item.update(resource_item_params)
	      	gon.resource_item = @resource_item
	        format.html { redirect_to @resource_item, notice: 'Resource item was successfully updated.' }
	        RestClient.patch("https://lensshift-drive.firebaseio.com/resources/#{@resource_item.google_doc_id}.json", @resource_item.to_json)
	        format.json { render json: @resource_item.to_json, status: :ok, location: @resource_item }
	      else
	      	gon.resource_item = resource_item_params
	        format.html { render :edit, location: @resource_item, status: :unprocessable_entity, error: @resource_item.errors }
	        format.json { render json: @resource_item.errors, status: :unprocessable_entity }
	      end
	    end
	end

	  # DELETE /resource_items/1
	  # DELETE /resource_items/1.json
	def destroy
		RestClient.patch("https://lensshift-drive.firebaseio.com/resources_deleted/#{@resource_item.google_doc_id}.json", @resource_item.to_json)
		RestClient.delete("https://lensshift-drive.firebaseio.com/resources/#{@resource_item.google_doc_id}.json")
		@resource_item.destroy
	    respond_to do |format|
	      format.html { redirect_to fellow_resource_items_url, notice: 'Resource item was successfully destroyed.' }
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
      	:google_doc_id, :published_at, :slug, :tag_list, :author_list, :file_id, :remote_image_url, :feature,
      	:article_title, :article_desc, :article_date, :article_content, :video_embed, :no_iframe)
    end
end
