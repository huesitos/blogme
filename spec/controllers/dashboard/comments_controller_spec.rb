require 'rails_helper'

RSpec.describe Dashboard::CommentsController, type: :controller do

  describe "DELETE destroy" do

    it "destroys an existing comment" do
      upost = create(:post)
      comment = create(:comment)
      upost.comments << comment

      expect{
        delete :destroy, id: comment.id
      }.to change(Comment, :count).by(-1)

      upost.reload

      expect(Comment.find_by(id: comment.id)).to eq nil
      expect(upost.comments).to_not include(comment)
      expect(response).to redirect_to(dashboard_post_path(upost.id))
    end
  end
end
