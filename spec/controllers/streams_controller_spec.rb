require 'rails_helper'

RSpec.describe StreamsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:lens_shifter)
    sign_in @user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      fellow = FactoryBot.create(:fellow)
      stream = FactoryBot.create(:stream, lens_shifter: fellow)
      lesson = FactoryBot.create(:lesson, stream: stream)
      get :show, params: {id: stream.to_param}
      expect(response).to have_http_status(:success)
    end
  end

end
