require 'rails_helper'

RSpec.describe Dashboard::AuthorsController, type: :controller do
  let(:author) { create (:author) }
  before(:each) { session[:author_id] = author.id }
  let(:author_hash) {
    {
      name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      nickname: Faker::Internet.user_name,
      image: Faker::Avatar.image,
      email: Faker::Internet.email,
      message: Faker::Lorem.sentence
    }
  }

  let(:password_hash) {
    {
      password: '123456',
      password_confirmation: '123456'
    }
  }

  shared_examples_for "renders" do |name, view|

    it "the #{name} template" do
      expect(response).to render_template(view)
      expect(response.status).to eq(200)
    end
  end

  describe "GET index" do
    before(:each) { get :index }

    it "assigns @authors" do
      expect(assigns(:authors)).to eq [author]
    end

    it_behaves_like "renders", 'index', :index
  end

  describe "GET new" do
    before(:each) { get :new }

    it_behaves_like "renders", 'new', :new
  end

  describe "GET edit" do
    before(:each) { get :edit, id: author.id }

    it_behaves_like "renders", 'edit', :edit

    it "assigns @author" do
      expect(assigns(:author)).to eq author
    end
  end

  describe "POST create" do

    it "creates a new author" do
      expect {
        post :create, author: author_hash, password: password_hash
      }.to change(Author, :count).by(1)

      author = Author.find_by(email: author_hash[:email])
      expect(author).to be_truthy
      expect(author.email).to eq author_hash[:email]
    end

    it "redirects to index when sucessful" do
      post :create, author: author_hash, password: password_hash

      author = assigns(:author)
      expect(response).to redirect_to("/dashboard/authors")
    end

    it "renders to the new template when unsuccessful" do
      post :create, author: { email: ''}, password: password_hash

      expect(response).to render_template(:new)
    end

    describe "validates" do

      it "email is present" do
        post :create, author: {email: '' }, password: password_hash

        author = assigns(:author)
        expect(author.errors.full_messages).to include("Email can't be blank")
      end

      it "email is unique" do
        post :create, author: { email: author.email }, password: password_hash

        author = assigns(:author)
        expect(author.errors.full_messages).to include(
          "Email has already been taken")
      end

      it "email has the correct format" do
        post :create, author: { email: 'something.not.email' }, password: password_hash

        author = assigns(:author)
        expect(author.errors.full_messages).to include(
          'Email must have the format youremail@domain.com')
      end

      it "password is of length >= 6" do
        post :create,
          author: { email: Faker::Internet.email },
          password: {password: '32', password_confirmation: '32'}

        author = assigns(:author)
        expect(author.errors.full_messages).to include(
          "Password is too short (minimum is 6 characters)"
        )
      end
    end
  end

  describe "PATCH update" do

    it "updates an existing author" do
      auth_id = author.id
      patch :update, id: author.id, author: author_hash

      author = Author.find(auth_id)
      expect(author.name).to eq author_hash[:name]
    end

    it "redirects to index when sucessful" do
      patch :update, id: author.id, author: author_hash

      author = assigns(:author)
      expect(response).to redirect_to("/dashboard/authors")
    end

    it "renders to the edit template when unsuccessful" do
      patch :update, id: author.id, author: { email: '' }

      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH update_social_links" do
    let(:social_links) {
      {
        google: 'google'
      }
    }

    it "updates the social links existing author" do
      auth_id = author.id
      patch :update_social_links, author_id: author.id, social_links: social_links

      author = Author.find(auth_id)
      expect(author.social_links[:google]).to eq social_links[:google]
    end

    it "redirects to index when sucessful" do
      patch :update_social_links, author_id: author.id, social_links: social_links

      author = assigns(:author)
      expect(response).to redirect_to("/dashboard/authors")
    end
  end

  describe "PATCH update_password" do
    let(:new_password) {
      {
        password: '123456',
        password_confirmation: '123456'
      }
    }

    it "updates the password an existing author" do
      auth_id = author.id
      patch :update_password, author_id: author.id, password: new_password

      author = Author.find(auth_id)
      expect(author.authenticate(new_password[:password])).to eq author
    end

    it "redirects to index when sucessful" do
      patch :update_password, author_id: author.id, password: new_password

      author = assigns(:author)
      expect(response).to redirect_to("/dashboard/authors")
    end
  end

  describe "DELETE destroy" do

    it "destroys an author" do
      author_id = author.id
      delete :destroy, id: author.id

      expect(Author.all.length).to eq 0
      expect(Author.find_by(id: author_id)).to eq nil
    end
  end
end
