class StreamsController < ApplicationController
  before_action :authenticate_lens_shifter!

  def index

    @page_title = 'Streams'
    @page_description = 'Our structured streams will walk you through 15-20 resources from the library to unpack topics fundamental to social impact. Learn more about important topics in a structured way' 
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
    @stream_image_url = stream.image.url

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
