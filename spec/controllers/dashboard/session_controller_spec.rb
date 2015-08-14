require 'rails_helper'

RSpec.describe Dashboard::SessionController, type: :controller do

  context "when login in" do

    describe "GET new" do

      it "renders the new (login) themplate" do
        get :new

        expect(response).to render_template(:new)
      end
    end

    describe "POST create" do

      it "only registered authors can login" do
        post :create,
          email: Faker::Internet.email,
          password: Faker::Internet.password
        expect(session[:author_id]).to be_nil

        author = create(:author)
        post :create, email: author.email, password: author.password
        expect(session[:author_id]).to eq author.id
      end

      it "redirects to dashboard posts when successful" do
        author = create(:author)

        post :create, email: author.email, password: author.password
        expect(response).to redirect_to('/dashboard/posts')
      end

      it "renders the login template when unsuccessful" do
        post :create,
          email: Faker::Internet.email,
          password: Faker::Internet.password

        expect(response).to render_template(:new)
      end
    end
  end

  context "when login in" do

    describe "DELETE destroy" do

      it "authors can logout" do
        author = create(:author)
        post :create, email: author.email, password: author.password

        delete :destroy
        expect(response).to render_template(:new)
        expect(session[:author_id]).to be_nil
      end
    end
  end
end
