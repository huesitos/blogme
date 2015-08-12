require 'rails_helper'

RSpec.describe Dashboard::PostsController, type: :controller do
  render_views

  context "when creating new posts" do

    describe "GET new" do
      before(:each) { get :new }

      it "renders the new template" do
        expect(response).to render_template(:new)
        expect(response.status).to eq(200)
      end

      it "renders a form with field title and description" do
        expect(response.body).to include("<form class='new_post' id='new_post' action='/dashboard/posts' method='post'")
        expect(response.body).to include("Title")
        expect(response.body).to include("Description")
        expect(response.body).to include("Tags")
      end
    end

    describe "POST create" do

      before(:each) do
        @new_post = {title: 'Un titulo', description: 'Una description'}
      end

      context "when tags don't exist" do
        it "creates the new tags" do
          post :create, :post => @new_post, :tags => "sports, science"

          created_post = Post.last
          expect(created_post).to be_truthy
          expect(created_post.title).to eq @new_post[:title]
          expect(created_post.description).to eq @new_post[:description]

          expect(Tag.all.length).to eq 2
          expect(Tag.find_by(name: 'sports')).to be_truthy
          expect(Tag.find_by(name: 'science')).to be_truthy
        end
      end

      context "when tags exist" do
        before(:context) do
          @cooking = create(:tag, name: 'cooking')
          @cooking.posts << create(:post)

          @health = create(:tag, name: 'health')
          @health.posts << create(:post)

          @tags = "cooking, health"
        end

        it "doesnt add new tags" do
          post :create, :post => @new_post, :tags => @tags

          created_post = Post.find_by(title: @new_post[:title])
          expect(created_post).to be_truthy
          expect(created_post.description).to eq @new_post[:description]

          expect(@cooking.posts.length).to eq 2
          expect(@health.posts.length).to eq 2
        end
      end

      context "responds by" do
        it "redirecting to index template when sucessful" do
          post :create, :post => @new_post, :tags => "sports, science"

          expect(response).to redirect_to('/dashboard/posts')
          expect(response.status).to eq 302
        end

        it "rendering the new template when unsuccessful" do
          post :create, :post => {title: '', description: ''}

          expect(response).to render_template(:new)
        end
      end

      context "validates" do

        it "post's title and description must be present" do
          post :create, :post => {title: '', description: ''}
          @post = assigns(:post)

          expect(@post.errors.full_messages.length). to eq 2
          expect(@post.errors.full_messages).to include(
            "Title can't be blank", 
            "Description can't be blank")
        end

        it "post's title length is <= 100" do
          post :create, :post => {
            title: Faker::Lorem.characters(101), 
            description: Faker::Lorem.paragraph}
          @post = assigns(:post)

          expect(@post.errors.full_messages.length).to eq 1
          expect(@post.errors.full_messages).to include(
            "Title is too long (maximum is 100 characters)")
        end
      end
    end
  end

  context "shows existing posts" do
    before(:context) { create_list(:post, 2) }

    describe "GET index" do

      it "displays all posts" do
        get :index

        expect(assigns(:posts)).to be_truthy
        expect(assigns(:posts)).to include(Post.first)
        expect(response).to render_template(:index)
      end

      fit "displays posts with an edit and delete link" do
        get :index

        expect(response.body).to include("<a href=\"/dashboard/posts/#{Post.first.id}/edit\">")
      end
    end
  end

  context "updates existing posts"

    describe "GET edit" do

      it "renders the edit template"
    end

    describe "PATCH update" do

      it "edits an existing post"
      it "redirects to index template when sucessful"
      it "renders the edit template when unsuccessful"
    end

  context "destroys existing post"

    describe "DELETE destroy" do

      it "destroy an existing post"
      it "redirects to the index template"
    end
  end
