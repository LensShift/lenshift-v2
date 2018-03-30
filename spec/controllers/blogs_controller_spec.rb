require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
	context 'valid blog params' do
		before(:each) do
			user = FactoryBot.create(:fellow)
			@blog = FactoryBot.create(:blog, lens_shifter: user)
		end
		describe "get#index" do
			it "should successfully render list of blogs" do
				get :index
				expect(response).to have_http_status(:success)
			end
		end

		describe "get#show" do
			it "should show blog content" do
				get :show, params: {id: @blog.to_param}
				expect(response).to have_http_status(:success)
			end
		end
	end

	context 'invalid blog params' do
		before(:each) do
			user = FactoryBot.create(:fellow)
			@blog = FactoryBot.create(:blog, lens_shifter: user)
		end

		describe "get#show" do
			it "should show 404 error" do
				get :show, params: {id: "GGGGA"}
				expect(response).to have_http_status(:not_found)
			end
		end
	end
end
