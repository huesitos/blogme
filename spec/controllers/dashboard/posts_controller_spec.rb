require 'rails_helper'

RSpec.describe Dashboard::PostsController, type: :controller do

  context "creates new posts" do

    describe "GET new" do
      render_views
      before(:each) { get :new }

      it "renders the new template" do
        expect(response).to render_template(:new)
        expect(response.status).to eq(200)
      end

      it "renders a form with field title and description" do
        expect(response.body.include? "<form class='new_post' id='new_post' action='/posts' method='post'")
        expect(response.body.include? "Title").to eq(true)
        expect(response.body.include? "Description").to eq(true)
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
