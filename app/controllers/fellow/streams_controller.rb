class Fellow::StreamsController < ApplicationController
  before_action :set_stream, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_fellow!

  # GET /fellow/streams
  # GET /fellow/streams.json
  def index
    @streams = Stream.all
  end

  # GET /fellow/streams/new
  def new
    lens_shift_fellows
    @stream = Stream.new
    gon.resources = ResourceItem.select(:id, :google_doc_id, :title).order(:google_doc_id)
  end

  # GET /fellow/streams/1/edit
  def edit
    gon.stream = @stream
    gon.lessons = @stream.lessons.order(:row_order).to_json(include: {syllabuses: {include: {resource_item: {:only => [:id, :google_doc_id, :title]}}}})
    gon.resources = ResourceItem.select(:id, :google_doc_id, :title).order(:google_doc_id)
    lens_shift_fellows
  end

  def show
    gon.stream = @stream.to_json(include: {lessons: {include: :resource_items}})
  end

  # POST /fellow/streams
  # POST /fellow/streams.json
  def create
    stream = Stream.new(stream_params)
      if stream.save
        if Rails.env.production?
          RestClient.patch("https://lensshift-drive.firebaseio.com/streams/#{stream.id}.json", stream.to_json(include: {lessons: {include: :resource_items}}))
        end
        render json: stream, status: :created, notice: 'Stream was successfully created.'
      else
        render json: render_errors(stream.errors), status: :unprocessable_entity
      end
  end

  # PATCH/PUT /fellow/streams/1
  # PATCH/PUT /fellow/streams/1.json
  def update
    respond_to do |format|
      if @stream.update(stream_params)
        gon.stream = @stream.to_json(include: {lessons: {include: :resource_items}})
        
        if Rails.env.production?
          RestClient.patch("https://lensshift-drive.firebaseio.com/streams/#{@stream.id}.json", gon.stream)
        end
        format.json { render json: @stream.to_json(include: {lessons: {include: :resource_items}}), status: :success }
        format.html { render :edit, status: :success, notice: 'Stream was successfully updated.' }
      else
        format.json { render json: render_errors(@stream.errors), status: :unprocessable_entity }
        format.html { render :edit, notice: @stream.errors.messages, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /fellow/streams/1
  # DELETE /fellow/streams/1.json
  def destroy
    return render json: render_errors({stream: "Cannot find the stream"}), status: :not_found if @stream.blank?
    # return render json: render_errors("you can't"), status: :forbidden if @stream.lens_shifter != current_lens_shifter
    
    if Rails.env.production?
      RestClient.patch("https://lensshift-drive.firebaseio.com/streams_deleted/#{@stream.id}.json", @stream.to_json(include: {lessons: {include: :resource_items}}))
      RestClient.delete("https://lensshift-drive.firebaseio.com/streams/#{@stream.id}.json")
    end
    @stream.destroy

    # head :no_contsent
    redirect_to fellow_streams_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stream
      @stream = Stream.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stream_params
      params.require(:stream).permit(:title, :description, :estimated_reading_time, :guiding_questions, :published_at,
        :tags, :tag_list, :slug, :image, :lens_shifter_id, lessons_attributes: [:id, :tittle, :_destroy, :row_order, :analysis, :_destroy, :row_order_position])
    end

    def render_errors(errors)
      { errors: errors }
    end

    def lens_shift_fellows
      gon.lens_shifters = LensShifter.where(admin: true).map {|x| {full_name: x.full_name, id: x.id}}
    end
end
