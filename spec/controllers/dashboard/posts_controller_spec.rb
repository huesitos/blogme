require 'rails_helper'

RSpec.describe Dashboard::PostsController, type: :controller do

  context "creates new posts" do

    describe "GET new" do

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
        expect(response).to eq(200)
      end
    end

    describe "POST create" do

      it "creates a new post"
      it "redirects to index template when sucessful"
      it "renders the new template when unsuccessful"
    end
  end

  context "shows existing posts" do

    describe "GET index" do

      it "displays all posts"
    end
  end

  context "updates and destroys existing posts"

    describe "GET edit" do

      it "renders the edit template"
    end

    describe "PATCH update" do

      it "edits an existing post"
      it "redirects to index template when sucessful"
      it "renders the edit template when unsuccessful"
    end

    describe "DELETE destroy" do

      it "destroy an existing post"
      it "redirects to the index template"
    end
  end
end
