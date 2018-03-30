require 'rails_helper'

RSpec.describe Fellow::PhotosController, type: :controller do
	before(:each) do
		user = FactoryBot.create(:fellow)
		sign_in user
	end

	context "valid params" do
		describe "photo#index" do
			it "should successfully render index page" do
				get :index
				expect(response).to have_http_status(:success)
			end
		end

		describe "photo#create" do
			it "should successfully add photo" do
				photoCount = Photo.count
				post :create, params: {photo: {image: "image.jpg"}}

				expect(Photo.count).to be > photoCount
				expect(response).to have_http_status(:created)
			end
		end

		describe "photo#delete" do
			it "should successfully delete photo" do
				photo = FactoryBot.create(:photo)
				delete :destroy, params: {id: photo.id}

				current_photo = Photo.find_by_id(photo.id)
				expect(current_photo).to eq nil
			end
		end

		describe "photo#update" do
			it "should successfully update photo" do
				photo = FactoryBot.create(:photo)
				patch :update, params: {id: photo.id, photo: {image: "newImage.jpg", title: "updated title"}}
				json = JSON.parse(response.body)

				expect(json['title']).to eq('updated title')
			end
		end
	end

	# context "invalid params" do
	# 	describe "photo#create" do
	# 		it "should render errors" do
	# 			photoCount = Photo.count
	# 			post :create, params: {photo: {image: ""}}

	# 			expect(Photo.count).to eq(photoCount)
	# 			expect(response).to have_http_status(:unprocessable_entity)
	# 		end
	# 	end
	# end
end
