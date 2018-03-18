require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
	before(:each) do
    	@user = FactoryBot.create(:lens_shifter)
    	sign_in @user
  	end

  	describe "GET #show" do
    	it "returns http success" do
    		page = FactoryBot.create(:static_page, lens_shifter: @user)
      		get :show, params: {id: page.to_param}
      		expect(response).to have_http_status(:success)
    	end
  	end

end
