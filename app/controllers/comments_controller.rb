class CommentsController < BlogControllerController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)

    if @comment.save
      @post.comments << @comment
      redirect_to post_path(@post.id)
    else
      redirect_to post_path(@post.id)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:name, :content)
    end
end
