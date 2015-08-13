require 'rails_helper'

RSpec.describe Dashboard::AuthorsController, type: :controller do

  let(:author) { create (:author) }

  shared_examples_for "renders" do |name, view|

    it "renders the #{name} template" do
      expect(response).to render_template(view)
      expect(response.status).to eq(200)
    end
  end

  describe "GET index" do

    it "assigns @authors" do
      get :index

      expect(assigns(:authors)).to eq [author]
    end

    it_behaves_like "renders", 'index', :index
  end

  describe "GET show" do

    it "assigns @author" do
      get :show, id: author.id

      expect(assigns(:author)).to eq author
    end

    it_behaves_like "renders", 'show', :show
  end

  describe "GET new" do

    it_behaves_like "renders", 'new', :new
  end

  describe "GET edit" do

    it_behaves_like "renders", 'edit', :edit

    it "assigns @author" do
      get :edit, author.id

      expect(assigns(:author)).to eq author
    end
  end

  describe "POST create" do
    let(:author_hash) {
      {
        name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        image: Faker::Avatar.image,
        email: Faker::Internet.email,
        password: Faker::Internet.password(8),
        message: Faker::Lorem.sentence
      }
    }

    it "creates a new author" do
      nauthors = Author.all.length

      post :create, author: author_hash

      author = Author.find_by(email: author_hash[:email])
      expect(author).to be_truthy
      expect(author.email).to eq author_hash[:email]
    end

    it "redirects to index when sucessful" do
      post :create, author: author_hash

      expect(response).to redirect_to(:index)
    end

    it "renders to the new template when unsuccessful" do
      post :create, author: {}

      expect(response).to render_template(:edit)
    end

    describe "validates" do

      it "email is present" do
        post :create, author: {}

        author = assigns(:author)
        expect(author.errors.full_messages).to include("Email can't be blank")
      end

      it "email is unique" do
        post :create, author: { email: author.email }

        author = assigns(:author)
        expect(author.errors.full_messages).to include("Email must be unique")
      end

      it "password is of length >= 6" do
        post :create, author: { password: '32' }

        author = assigns(:author)
        expect(author.errors.full_messages).to include(
          "Password is too short ( minimum length is 6 characters)")
      end
    end
  end

  describe "PATCH update" do
    let(:author_hash) {
      {
        name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        image: Faker::Avatar.image,
        email: Faker::Internet.email,
        password: Faker::Internet.password(8),
        message: Faker::Lorem.sentence
      }
    }

    it "updates an existing author" do
      auth_id = author.id
      patch :update, id: author.id, author: author_hash

      author = Author.find(auth_id)
      expect(author.name).to eq author_hash[:name]
    end

    it "redirects to index when sucessful" do
      patch :update, id: author.id, author: author_hash

      expect(response).to redirect_to(:index)
    end

    it "renders to the edit template when unsuccessful" do
      patch :update, id: author.id, author: {}

      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE destroy" do

    it "destroys an author" do
      delete :destroy, id: author.id

      expect(Author.all.length).to eq 0
      expect(author).to be_falsy
    end
  end
end
