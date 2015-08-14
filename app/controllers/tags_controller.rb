class TagsController < ApplicationController

  def show
    @tag = Tag.find_by(name: params[:tag])
    @posts = @tag.posts
  end
end
