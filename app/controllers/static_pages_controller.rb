class StaticPagesController < ApplicationController
  def index
  end

  def show
  	@page = StaticPage.friendly.find(params[:id])
  	if request.path != static_page_path(@page)
      redirect_to @page, status: :moved_permanently
    end
  end
end
