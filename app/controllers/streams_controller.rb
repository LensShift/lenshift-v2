class StreamsController < ApplicationController
  def index
  	gon.streams = Stream.all.to_json({include: :lessons})
  end

  def show
  	stream = Stream.friendly.find(params[:id])
  	gon.stream = stream
  	if request.path != stream_path(stream)
      redirect_to stream, status: :moved_permanently
    end
  end
end
