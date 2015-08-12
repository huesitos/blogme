class PostsController < ApplicationController
  def index
    @posts = Post.all
    @tags_with_frequency = Tag.all.map do |tag| 
      [tag, tag.posts.length]
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
