class ResourceItemsController < ApplicationController
  before_action :authenticate_lens_shifter!
  before_action :set_resource_item, only: [:show]
  
  def index
      @page_title = 'Library'
      @page_description = 'Welcome our comprehensive library of resources including articles, videos, podcasts, infographics, etc. We bring together powerful content about social impact for you so that you can find them in one place.'
      @page_keywords = 'Resource, Library, International Development, Social Impact'

      resources = ResourceItem.published_before(Time.zone.now).select(:id, :title, :image, :short_summary, :resource_type).page(params[:page]).per(12)
      gon.resources = resources
      gon.icons = ResourceItem::RESOURCE_TYPE

      respond_to do |format|
        format.html
        format.json {render json: resources}
      end
  end

  def show
    @resource_tags = @resource_item.tag_counts_on(:tag)

    @page_title = @resource_item.title
    @page_description = truncate(@resource_item.short_summary, length: 140)
    @page_keywords = @resource_item.tag_list

    gon.resource = @resource_item
    if request.path != resource_item_path(@resource_item)
      redirect_to @resource_item, status: :moved_permanently
    end
  end

  private

  def set_resource_item
     @resource_item = ResourceItem.friendly.find(params[:id])
  end
end
