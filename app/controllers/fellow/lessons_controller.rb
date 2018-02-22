class Fellow::LessonsController < ApplicationController
  before_action :authenticate_fellow!

  def create
  	# resource_ids = lesson_params[:resources].map{|x| x[:id]}
  	lesson = Lesson.new(lesson_params)
      if lesson.save
        render json: lesson.to_json(include: :resource_items), status: :created, notice: 'Lesson was successfully created.'
      else
        render json: render_errors(lesson.errors), status: :unprocessable_entity
      end
  end

  def update
  		# resource_ids = lesson_params[:resources].map{|x| x[:id]} if lesson_params[:resources].present?
      stream = Stream.friendly.find(lesson_params[:stream_id])
      if stream.lesson.find(params[:id]).update(lesson_params)
        render json: lesson, status: :created, notice: 'Lesson was successfully updated.'
      else
        render json: render_errors(lesson.errors), status: :unprocessable_entity
      end
  end

  def destroy
  	lesson = Lesson.friendly.find(params[:id])
  	return render json: render_errors("Cannot find the lesson"), status: :not_found if lesson.blank?
    lesson.destroy

    head :no_content
  end

  private

  def lesson_params
  	params.require(:lesson).permit(:title, :analysis, :stream_id, :resource_item_ids => [], :syllabuses_attributes => [:row_order_position])
  end

  def render_errors(errors)
      { errors: errors }
  end
end
