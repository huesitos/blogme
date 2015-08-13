require 'rails_helper'

RSpec.describe Dashboard::TagsController, type: :controller do
	before(:context) do
    @tag = create(:tag, name: "cooking")
    @post = create(:post)
    @tag.posts << @post
  end

  describe "GET show" do

    it "assigns @posts that belong to tag" do
      get :show, id: @tag.id
      posts = assigns(:posts)
      expect(posts).to eq([@post])
      expect(posts.length).to eq 1
    end

    it "renders the show template" do
      get :show, id: @tag.id
      expect(response).to render_template(:show)
      expect(response.status).to eq(200)
    end
  end
end
