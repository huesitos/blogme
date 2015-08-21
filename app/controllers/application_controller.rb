class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_author

  private

    def current_author
      if session[:author_id]
        @current_author ||= Author.find_by(id: session[:author_id])
      else
        @current_author = nil
      end
    end

    def popular_posts
      @popular_posts = Post.all.order(view_count: :desc).limit(5)
    end

    def get_archive
      @archive = {}
      Post.all.each do |post|
        if @archive["#{post.created_at.strftime("%B %Y")}"]
          @archive["#{post.created_at.strftime("%B %Y")}"] << [post.title, post.id]
        else
          @archive["#{post.created_at.strftime("%B %Y")}"] = [[post.title, post.id]]
        end
      end
    end
end
