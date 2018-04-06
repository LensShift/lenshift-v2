require 'rails_helper'

RSpec.describe Fellow::BlogsController, type: :controller do
  	describe "GET #index" do
  		before(:each) do
  			user = FactoryBot.create(:fellow)
    		sign_in user
    	end
    	it "returns http success" do
      		get :index
      		expect(response).to have_http_status(:success)
    	end
  	end

  	context "valid lens_shifter" do
  		before(:each) do
  			user = FactoryBot.create(:fellow)
  			sign_in user
			@blog = FactoryBot.create(:blog, lens_shifter: user )
	  	end
	  	describe "blog#edit" do
	  		it "successfully show blog in edit" do
	  			get :edit, params: {id: @blog.id}
	  			expect(response).to have_http_status(:success)
	  		end
	  	end

	  	describe "blog#new" do
	  		it "successfully show blog in edit" do
	  			get :new
	  			expect(response).to have_http_status(:success)
	  		end
	  	end
	end

  	context "valid blog post" do
  		before(:each) do
  			@user = FactoryBot.create(:fellow)
			@blog = FactoryBot.create(:blog, lens_shifter: @user )
		end
	  	describe "blog#create" do
	    	it "successfully create blog" do
	    		sign_in @user
	    		blogCount = Blog.count
	    		post :create, params: {blog: {title: 'New Blog', content: "Blog Content"}}
	    		json = JSON.parse(response.body)
	    		expect(response).to have_http_status(:created)
	    		expect(Blog.count).to be > blogCount 
	    		expect(json['title']).to eq('New Blog')
	    		expect(json['content']).to eq('Blog Content')
	    	end
	    end

	    describe "blog#update" do
	    	it "successfully update blog" do
	    		sign_in @user
	    		patch :update, params: {id: @blog.id, blog: {title: 'New Blog Updated', content: "Blog Content Updated"}}
	    		json = JSON.parse(response.body)
	    		
	    		expect(json['title']).to eq('New Blog Updated')
	    		expect(json['content']).to eq('Blog Content Updated')
	    		expect(response).to be_success
	    	end

	    	it "shouldn't allow non-authorised user to update the post" do
	    		user2 = FactoryBot.create(:fellow)
	    		sign_in user2
	    		patch :update, params: {id: @blog.id, blog: {title: 'New Blog Updated', content: "Blog Content Updated"}}
	    		json = JSON.parse(response.body)
	    		
	    		expect(response).to have_http_status(:unprocessable_entity)
	    	end
	    end

	    describe "blog#destroy" do
			it "successfully delete a blog" do
				sign_in @user
				delete :destroy, params: {id: @blog.id}
				blog = Blog.find_by_id(@blog.id)
				expect(blog).to eq nil
				expect(response).to redirect_to fellow_blogs_path
			end

			it "shouldn't allow non-authorised user to delete the post" do
				user2 = FactoryBot.create(:fellow)
				sign_in user2
				delete :destroy, params: {id: @blog.id}
				expect(response).to redirect_to fellow_blogs_path
			end
		end
	end

	context "invalid id params" do
		before(:each) do
  			@user = FactoryBot.create(:fellow)
			@blog = FactoryBot.create(:blog, lens_shifter: @user )
	  	end

	  	describe "blog#edit" do
			it "should return a 404 if blog cannot be found" do
				sign_in @user
				get :edit, params: {id: "BBBAG"}
				expect(response).to have_http_status(:not_found)
			end
	  	end

	  	describe "blog#update" do
			it "should return a 404 if blog cannot be found" do
				sign_in @user
				patch :update, params: {id: "BBBAG"}
				expect(response).to have_http_status(:not_found)
			end
	  	end

		describe "blog#destroy" do
			it "should return a 404 if blog cannot be found" do
				sign_in @user
				delete :destroy, params: {id: "BBBAG"}
				expect(response).to have_http_status(:not_found)
			end
		end
	end

	context "invalid blog post" do
		describe "blog#create" do
			before(:each) do
				user = FactoryBot.create(:fellow)
	    		sign_in user
			end

			it "should validate blog title to not be nil" do
				post :create, params: {blog: {title: '', content: "Blog Content"}}
				expect(response).to have_http_status(:unprocessable_entity)
			end
		end
	end

	
end
