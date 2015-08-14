require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  before(:each) do
    @tag = create(:tag, name: "cooking")
    @post = create(:post)
    @tag.posts << @post
  end

  describe "GET show" do

    it "assigns @posts that belong to tag" do
      get :show, tag: @tag.name
      posts = assigns(:posts)
      expect(posts).to eq([@post])
      expect(posts.length).to eq 1
    end

    it "renders the show template" do
      get :show, tag: @tag.name
      expect(response).to render_template(:show)
      expect(response.status).to eq(200)
    end
  end
end
