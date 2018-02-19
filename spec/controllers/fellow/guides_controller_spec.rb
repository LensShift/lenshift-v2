require 'rails_helper'

RSpec.describe Fellow::GuidesController, type: :controller do
  before(:each) do
      user = FactoryBot.create(:fellow)
      sign_in user
  end
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      guide = FactoryBot.create(:guide)

      get :edit, params: {id: guide.id}
      expect(response).to have_http_status(:success)
    end
  end
end
