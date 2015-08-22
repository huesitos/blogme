require 'rails_helper'

RSpec.describe Dashboard::PagesController, type: :controller do

  before(:each) do
    author = create(:author, role: "admin")
    session[:author_id] = author.id
  end

  describe "GET #index" do
    it "assigns @pages" do
      page = create(:page)

      get :index

      pages = assigns[:pages]
      expect(pages).to eq([page])
      expect(pages).to be_truthy
      expect(response).to render_template(:index)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      page = create(:page)

      get :edit, id: page.id
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    it "creates a new page" do
      page = {name: 'About', content: 'This is my content'}

      expect {
        post :create, page: page
      }.to change(Page, :count).by(1)

      new_page = Page.find_by(name: page[:name])
      expect(new_page).to be_truthy
      expect(new_page.name).to eq page[:name]
      expect(response).to redirect_to(dashboard_pages_path)
      expect(flash[:success]).to be_truthy
    end
  end

  describe "PATCH #update" do
    it "updates an existing page" do
      page = create(:page)
      new_name = 'Papercraft'

      get :update, id: page.id, page: {name: new_name}

      edited_page = Page.find_by(name: new_name)
      expect(edited_page.name).to eq(new_name)
      expect(response).to redirect_to(dashboard_pages_path)
    end

    describe "when unsuccessful" do
      it "renders the edit template " do
        page = create(:page)
        get :update, id: page.id, page: {name: '', content: ''}

        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroy an existing page" do
      page = create(:page)
      cid = page.id

      expect{
        delete :destroy, id: page.id
      }.to change(Page, :count).by(-1)

      expect(Page.find_by(id: page.id)).to be_falsy
    end
  end

end
