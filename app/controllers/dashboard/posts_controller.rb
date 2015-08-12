class Dashboard::PostsController < ApplicationController
  def new
    @post = Post.new

    respond_to do |format|
      format.html { render :new }
    end
  end
end
