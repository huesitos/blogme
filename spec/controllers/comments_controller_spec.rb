require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "POST create" do

    it "creates a new comment on a post" do
      upost = create(:post)
      ch = { name: "Denisse", content: "El comentario." }

      expect {
        post :create, post_id: upost.id, comment: ch
      }.to change(Comment, :count).by(1)

      comment = assigns[:comment]
      expect(comment.post).to eq upost
      expect(comment.name).to eq ch[:name]
    end

    it "redirects to the post show template" do
      upost = create(:post)
      ch = { name: "Denisse", content: "El comentario." }
      post :create, post_id: upost.id, comment: ch

      expect(response).to redirect_to(post_path(upost.id))
    end

    it "makes the post anonymous if no name is given" do
      upost = create(:post)
      ch = { content: "El comentario." }
      post :create, post_id: upost.id, comment: ch

      comment = assigns[:comment]
      expect(comment.post).to eq upost
      expect(comment.name).to eq 'Anonymous'
    end
  end
end
