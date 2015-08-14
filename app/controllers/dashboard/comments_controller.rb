class Dashboard::CommentsController < ApplicationController

  def destroy
    @comment = Comment.find(params[:id])
    post_id = @comment.post.id
    @comment.destroy

    redirect_to dashboard_post_path(post_id)
  end
end
