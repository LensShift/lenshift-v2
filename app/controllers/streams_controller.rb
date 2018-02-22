class StreamsController < ApplicationController
  before_action :authenticate_lens_shifter!

  def index
  	gon.streams = Stream.all.to_json({include: :lessons})
  end

  def show
  	stream = Stream.friendly.find(params[:id])
    gon.stream = stream.to_json(include: {lessons: {include: :resource_items}})
  	if request.path != stream_path(stream)
      redirect_to stream, status: :moved_permanently
    end
  end

  def preview
    stream = Stream.friendly.find(params[:id]).select(:title, :description, :guiding_questions, :estimated_reading_time, :image)
    gon.stream = stream
    if request.path != stream_path(stream)
      redirect_to stream, status: :moved_permanently
    end
  end
end
