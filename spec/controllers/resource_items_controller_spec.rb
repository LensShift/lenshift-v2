require 'rails_helper'

RSpec.describe ResourceItemsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      resource = FactoryBot.create(:resource_item)
      get :show, id: resource.id
      expect(response).to have_http_status(:success)
    end
  end

end
