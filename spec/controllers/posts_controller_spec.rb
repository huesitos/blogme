require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET index" do

    it "assigns @posts" do
      post = create(:post)
      get :index
      expect(assigns(:posts)).to eq([post])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
      expect(response).to have_http_status(:ok)
    end
  end
end
