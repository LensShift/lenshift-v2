class LessonsController < ApplicationController
  def show
  	lesson = Lesson.find(params[:id])
  	return render json: render_errors("Cannot find resources"), status: :not_found if lesson.blank?

  	render json: lesson.resource_items.as_json
  end

  private

  def render_errors(note)
  	{ errors: note }
  end
end
