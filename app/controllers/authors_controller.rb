class AuthorsController < ApplicationController

  def show
    @author = Author.find_by(nickname: params[:nickname])
    @posts = @author.posts
  end
end
