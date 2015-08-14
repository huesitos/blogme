class Dashboard::SessionController < ApplicationController
  def new
  end

  def create
    author = Author.find_by(email: params[:email])

    if author and author.authenticate(params[:password])
        session[:author_id] = author.id
        redirect_to :dashboard_posts
    else
      render "new"
    end
  end

  def destroy
    session[:author_id] = nil
    render "new"
  end
end
