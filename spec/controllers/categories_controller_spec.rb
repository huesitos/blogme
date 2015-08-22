require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      category = create(:category)

      get :show, category: category.name
      expect(response).to have_http_status(:success)
    end
  end

end
