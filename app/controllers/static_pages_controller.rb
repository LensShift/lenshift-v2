class StaticPagesController < ApplicationController
  before_action :authenticate_lens_shifter!
  layout :static_layout

  def landing
  end

  def home
  end

  def show
  	@page = StaticPage.friendly.find(params[:id])
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
