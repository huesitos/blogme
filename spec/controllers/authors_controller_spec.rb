require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  before(:each) do
    @author = create(:author)
    @post = create(:post)
    @author.posts << @post
  end

  describe "GET show" do

    it "assigns @posts that belong to author" do
      get :show, nickname: @author.nickname
      posts = assigns(:posts)
      expect(posts).to eq([@post])
      expect(posts.length).to eq 1
    end

    it "renders the show template" do
      get :show, nickname: @author.nickname
      expect(response).to render_template(:show)
      expect(response.status).to eq(200)
    end
  end
end
