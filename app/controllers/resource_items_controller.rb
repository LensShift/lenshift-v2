class ResourceItemsController < ApplicationController
  before_action :set_resource_item, only: [:show]
  
  def index
      @resource_items = ResourceItem.order(params[:sort_by]).page(params[:page])
      gon.resources = @resource_items
      gon.icons = ResourceItem::RESOURCE_TYPE
  end

  def show
    @resource_tags = @resource_item.tag_counts_on(:tag)
    @article = ArticleCrawler.new(@resource_item.source_url)
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
