class AuthorsController < ApplicationController
  before_action :popular_posts
  before_action :get_archive

  def show
    @author = Author.find_by(nickname: params[:nickname])
    @posts = @author.posts

    render 'posts/index'
  end
end
