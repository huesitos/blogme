class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Tag.find_by(name: params[:tag]).posts
    else
      @posts = Post.all
    end

    @tags_with_frequency = Tag.all.map do |tag|
      [tag, tag.posts.length]
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
