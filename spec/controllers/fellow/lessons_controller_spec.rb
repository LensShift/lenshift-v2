require 'rails_helper'

RSpec.describe Fellow::LessonsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:fellow)
    sign_in @user
  end
  
  describe "fellow/lessons#create" do
    it "returns http success" do
      stream = FactoryBot.create(:stream, lens_shifter: @user)

      post :create, params: {lesson: {title: 'New Title', analysis: 'New Analysis', stream_id: stream.id}}
      expect(response).to have_http_status(:success)
    end

    it "should successfully create a lesson" do
      stream = FactoryBot.create(:stream, lens_shifter: @user)
      lessonCount = stream.lessons.count
      post :create, params: {lesson: {title: 'New Title', analysis: 'New Analysis', stream_id: stream.id}}
      expect(stream.lessons.count).to be > lessonCount
    end
  end

  describe "fellow/lessons#update" do
    before do
      @stream = FactoryBot.create(:stream, lens_shifter: @user)
      @lesson = FactoryBot.create(:lesson, stream: @stream)
    end
    it "returns http success" do
      put :update, params: {id: @lesson.id, stream_id: @stream.id, lesson: {title: 'Title Updated', analysis: 'Analysis Updated'}}
      json = JSON.parse(response.body)

      expect(json['title']).to eq('Title Updated')
      expect(json['analysis']).to eq('Analysis Updated')
      expect(response).to be_success
    end
  end

  describe "fellow/lessons#destroy" do
    before do
      @stream = FactoryBot.create(:stream, lens_shifter: @user)
      @lesson = FactoryBot.create(:lesson, stream: @stream)
    end
    it "should destroy a lesson" do
      delete :destroy, params: { id: @lesson.id}

      lessons = Lesson.find_by_id(@lesson.id)
      expect(lessons).to eq nil
    end
    it "should return no_content status" do
      delete :destroy, params: { id: @lesson.id}
      expect(response).to have_http_status(:no_content)
    end

  end

end
