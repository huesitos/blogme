require 'rails_helper'

RSpec.describe Dashboard::PostsController, type: :controller do

  shared_examples_for "form template" do |name, view, extra|

    it "renders the #{name} template" do
      expect(response).to render_template(view)
      expect(response.status).to eq(200)
    end
  end

  describe "creates new posts" do

    describe "GET new" do
      before(:each) { get :new }

      it_behaves_like "form template", 'new', :new
    end

    describe "POST create" do
      let(:new_post) {{title: 'Un titulo', description: 'Una description'}}

      before(:each) do
        post :create, :post => new_post, :tags => "sports, science"
      end

      it "create a new post" do
        created_post = Post.last
        expect(created_post).to be_truthy
        expect(created_post.title).to eq new_post[:title]
        expect(created_post.description).to eq new_post[:description]
      end

      context "when tags don't exist" do

        it "creates the new tags" do
          expect(Tag.all.length).to eq 2
          expect(Tag.find_by(name: 'sports')).to be_truthy
          expect(Tag.find_by(name: 'science')).to be_truthy
        end
      end

      context "when tags exist" do
        let(:tags) { "cooking, health"}

        before(:each) do
          @cooking = create(:tag, name: 'cooking')
          @cooking.posts << create(:post)

          @health = create(:tag, name: 'health')
          @health.posts << create(:post)

        end

        it "doesnt add new tags" do
          post :create, :post => new_post, :tags => tags

          created_post = Post.find_by(title: new_post[:title])
          expect(created_post).to be_truthy
          expect(created_post.description).to eq new_post[:description]

          expect(@cooking.posts.length).to eq 2
          expect(@health.posts.length).to eq 2
        end
      end

      describe "responds by" do

        it "redirecting to index template when sucessful" do
          expect(response).to redirect_to(:dashboard_posts)
          expect(response.status).to eq 302
        end

        it "rendering the new template when unsuccessful" do
          post :create, :post => {title: '', description: ''}

          expect(response).to render_template(:new)
        end
      end

      describe "validates" do

        it "post's title and description must be present" do
          post :create, :post => {title: '', description: ''}
          upost = assigns(:post)

          expect(upost.errors.full_messages.length). to eq 2
          expect(upost.errors.full_messages).to include(
            "Title can't be blank",
            "Description can't be blank")
        end

        it "post's title length is <= 100" do
          post :create, :post => {
            title: Faker::Lorem.characters(101),
            description: Faker::Lorem.paragraph}
          upost = assigns(:post)

          expect(upost.errors.full_messages.length).to eq 1
          expect(upost.errors.full_messages).to include(
            "Title is too long (maximum is 100 characters)")
        end
      end
    end
  end

  describe "shows existing posts" do
    before(:each) { create_list(:post, 2) }

    describe "GET index" do

      it "displays all posts" do
        get :index

        expect(assigns(:posts)).to be_truthy
        expect(assigns(:posts)).to include(Post.first)
        expect(response).to render_template(:index)
      end
    end
  end

  describe "updates existing posts"

    describe "GET edit" do
      before(:each) do
        post = create(:post)
        post.tags << create(:tag)
        get :edit, id: post.id
      end

      it_behaves_like "form template", 'edit', :edit
    end

    describe "PATCH update" do
      before(:each) do
        @post = create(:post)
        @tag = create(:tag, name: "health")
        @post.tags << @tag

        @new_values = {
          title: Faker::Lorem.sentence(5),
          description: Faker::Lorem.paragraph
        }
      end

      it "updates an existing post" do
        patch :update, id: @post.id, post: @new_values, tags: @tag.name
        upost = assigns(:post)

        expect(upost.title).to eq @new_values[:title]
        expect(upost.description).to eq @new_values[:description]
      end

      describe "edits the post tags by" do

        it "changing them" do
          expect(@tag.posts.length).to eq 1

          patch :update, id: @post.id, post: @new_values, tags: 'desserts'

          upost = assigns(:post)

          expect(upost.tags.length).to eq 1
          expect(upost.tags.first.name).to eq "desserts"
        end

        it "removing them" do
          patch :update, id: @post.id, post: @new_values, tags: ''
          upost = assigns(:post)

          expect(upost.tags.length).to eq 0
          expect(@tag.posts.length).to eq 0
        end

        it "destroying the ones that don't refer to any post" do
          expect(@tag.posts.length).to eq 1
          patch :update, id: @post.id, post: @new_values, tags: 'desserts'
          expect(Tag.find_by(name: @tag.name)).to eq nil
        end
      end

      describe "responds by" do

        it "redirecting to index template when sucessful" do
          expect(response.status).to eq 200
        end

        it "rendering the edit template when unsuccessful" do
          patch :update,
            id: @post.id,
            post: {title: '', description: ''},
            tags: 'health'

          expect(response).to render_template(:edit)
        end
      end
    end

  describe "destroys existing post"

    describe "DELETE destroy" do
      let(:post) { create(:post) }

      it "destroy an existing post" do
        delete :destroy, id: post.id

        expect(Post.all.length).to eq 0
      end

      it "redirects to the index template" do
        delete :destroy, id: post.id

        expect(response).to redirect_to(:dashboard_posts)
      end
    end
  end
