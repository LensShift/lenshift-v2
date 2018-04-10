class StaticPagesController < ApplicationController
  # before_action :authenticate_lens_shifter!, except: [:home, :landing]
  layout :static_layout

  # def landing
  # end

  def home
    if lens_shifter_signed_in?
      redirect_to resource_items_path
    end
  end

  def show
  	@page = StaticPage.friendly.find(params[:id])
    @page_title = @page.title
    @page_description = truncate(@page.content.html_safe, length: 140)
  	if request.path != static_page_path(@page)
      redirect_to @page, status: :moved_permanently
    end
  end

  def contact
  end


  private

  def static_layout
    case action_name
    when 'landing'
      'landing'
    when 'home'
      'home'
    else
      "application"
    end
  end
end
