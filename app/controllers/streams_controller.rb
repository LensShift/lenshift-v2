class StreamsController < ApplicationController
  # before_action :authenticate_lens_shifter!, only: [:show]

  def index
  	gon.streams = Stream.published_before(Time.zone.now).to_json({include: {lessons: { only: [:title]}}})
  end

  def show
  	stream = Stream.friendly.find(params[:id])
    gon.stream = stream

    lessons = stream.lessons.order(:row_order)

    gon.lessons = lessons
    gon.firstResources = lessons.first.resource_items

    gon.lessonsCount = lessons.size
    resourcesCount = 0

    stream.lessons.each do |lesson|
      resourcesCount += lesson.resource_items.size
    end

    gon.resourcesCount = resourcesCount


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
