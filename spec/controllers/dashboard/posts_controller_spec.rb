require 'rails_helper'

RSpec.describe Dashboard::PostsController, type: :controller do
  render_views

  shared_examples_for "form template" do |name, view, extra|

    fit "renders the #{name} template" do
      expect(response).to render_template(view)
      expect(response.status).to eq(200)
    end

    fit "renders a form with field title, description, and tags" do
      expect(response.body).to include("class=\"#{name}_post\"")
      expect(response.body).to include("Title")
      expect(response.body).to include("Description")
      expect(response.body).to include("Tags")
    end
  end

  context "when creating new posts" do

    describe "GET new" do
      before(:each) { get :new }

      it_behaves_like "form template", 'new', :new
    end

    describe "POST create" do

      before(:each) do
        @new_post = {title: 'Un titulo', description: 'Una description'}
        post :create, :post => @new_post, :tags => "sports, science"
      end

      it "create a new post" do
        created_post = Post.last
        expect(created_post).to be_truthy
        expect(created_post.title).to eq @new_post[:title]
        expect(created_post.description).to eq @new_post[:description]
      end

      context "when tags don't exist" do

        it "creates the new tags" do
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

      it "displays posts with an edit and delete link" do
        get :index

        expect(response.body).to include("href=\"/dashboard/posts/#{Post.first.id}/edit\"")
        expect(response.body).to include("href=\"/dashboard/posts/#{Post.first.id}\"")
      end
    end
  end

  context "updates existing posts"

    describe "GET edit" do
      before(:each) do
        post = create(:post)
        post.tags << create(:tag)
        get :edit, id: post.id
      end

      it_behaves_like "form template", 'edit', :edit

      it "includes the post's attributes values in the form" do
        post = assigns(:post)

        expect(response.body).to include(post.title)
        expect(response.body).to include(post.description)
        expect(response.body).to include(post.tags.map(&:name).join(', '))
      end
    end

    describe "PATCH update"

  context "destroys existing post"

    describe "DELETE destroy" do

      it "destroy an existing post"
      it "redirects to the index template"
    end
  end
