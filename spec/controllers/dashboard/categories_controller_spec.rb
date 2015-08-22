require 'rails_helper'

RSpec.describe Dashboard::CategoriesController, type: :controller do

  before(:each) do
    author = create(:author, role: "admin")
    session[:author_id] = author.id
  end

  describe "GET #index" do
    it "assigns @categories" do
      category = create(:category)

      get :index

      categories = assigns[:categories]
      expect(categories).to eq([category])
      expect(categories).to be_truthy
      expect(response).to render_template(:index)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      category = create(:category)

      get :edit, id: category.id
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    it "creates a new category" do
      category = {name: 'Papercraft'}

      expect {
        post :create, category: category
      }.to change(Category, :count).by(1)

      new_category = Category.find_by(name: category[:name])
      expect(new_category).to be_truthy
      expect(new_category.name).to eq category[:name]
      expect(response).to redirect_to(dashboard_categories_path)
      expect(flash[:success]).to be_truthy
    end
  end

  describe "PATCH #update" do
    it "updates an existing category" do
      category = create(:category)
      new_name = 'Papercraft'

      get :update, id: category.id, category: {name: new_name}

      edited_category = Category.find_by(name: new_name)
      expect(edited_category.name).to eq(new_name)
      expect(response).to redirect_to(dashboard_categories_path)
    end

    describe "when unsuccessful" do
      it "renders the edit template " do
        category = create(:category)
        get :update, id: category.id, category: {name: ''}

        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroy an existing category" do
      category = create(:category)
      cid = category.id

      expect{
        delete :destroy, id: category.id
      }.to change(Category, :count).by(-1)

      expect(Category.find_by(id: category.id)).to be_falsy
    end
  end

end
