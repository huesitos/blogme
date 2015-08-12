require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before(:context) { @post = create(:post) }

  describe "GET index" do

    it "assigns @posts" do
      get :index
      expect(assigns(:posts)).to eq([@post])
    end

    it "assigns @tags_with_frequency" do
      tag = create(:tag)
      @post.tags << tag

      get :index
      tags_with_frequency = assigns(:tags_with_frequency)

      expect(tags_with_frequency).to eq([[tag,1]])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET show" do

    it "assigns @post" do
      get :show, id: 1
      expect(assigns(:post)).to eq(@post)
    end

    it "renders the show template" do
      get :show, id: 1
      expect(response).to render_template("show")
      expect(response).to have_http_status(:ok)
    end
  end
end
