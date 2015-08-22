require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #show" do
    let(:page) { create(:page) }
    it "returns http success" do
      get :show, name: page.name
      expect(response).to have_http_status(:success)
    end

    it "assigns @page" do
      get :show, name: page.name

      apage = assigns[:page]
      expect(page).to be_truthy
      expect(apage.name).to eq page.name
    end
  end

end
