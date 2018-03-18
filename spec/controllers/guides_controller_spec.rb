require 'rails_helper'

RSpec.describe GuidesController, type: :controller do
	before(:each) do
    	@user = FactoryBot.create(:lens_shifter)
    	sign_in @user
  	end
	describe "GET #index" do
		it "should returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end
end
