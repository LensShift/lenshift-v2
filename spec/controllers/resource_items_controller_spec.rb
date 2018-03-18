require 'rails_helper'

RSpec.describe ResourceItemsController, type: :controller do
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
      resource = FactoryBot.create(:resource_item)
      get :show, params: {id: resource.to_param}
      expect(response).to have_http_status(:success)
    end
  end

end
