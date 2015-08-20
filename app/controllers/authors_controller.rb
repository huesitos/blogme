class AuthorsController < ApplicationController
  before_action :popular_posts

  def show
    @author = Author.find_by(nickname: params[:nickname])
    @posts = @author.posts

    render 'posts/index'
  end
end
