class StreamsController < ApplicationController
  before_action :authenticate_lens_shifter!, only: [:show]

  def index

    @page_title = 'Streams'
    @page_description = 'These structured Streams walk LensShifters through 15-20 resources from the Library to unpack topics fundamental to challenging mainstream narratives.' 
    @page_keywords = 'learn, stream, guided, curated, social impact'
  	gon.streams = Stream.published_before(Time.zone.now).to_json({include: {lessons: { only: [:title]}}})
  end

  def show
  	stream = Stream.friendly.find(params[:id])

    # SEO meta tags
    @page_title = stream.title
    @page_description = stream.description
    @page_keywords = stream.tag_list
    @stream_id = stream.id
    @stream_image_url = stream.image_url

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
    stream = Stream.friendly.find(params[:id]).select(:title, :description, :guiding_questions, :tag_list, :estimated_reading_time, :image)
    # SEO meta tags
    @page_title = stream.title
    @page_description = stream.description
    @page_keywords = stream.tag_list
    @stream_id = stream.id
    @stream_image_url = stream.image_url

    gon.stream = stream
    lessons = stream.lessons.order(:row_order)

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

end
