class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Tag.find_by(name: params[:tag]).posts
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(name: '')
  end
end
