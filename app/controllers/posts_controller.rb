class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Tag.find_by(name: params[:tag]).posts
    else
      @posts = Post.all.order(created_at: :desc)
    end
    @posts.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(name: '')
    @comments = @post.comments.order(created_at: :desc)
  end
end
