class BlogController < ApplicationController
  before_action :popular_posts
  before_action :recent_posts
  before_action :archive
  before_action :categories
  before_action :pages

  private

    def popular_posts
      @popular_posts = Post.all.order(view_count: :desc).limit(5)
    end

    def recent_posts
      @recent_posts = Post.all.order(created_at: :desc).limit(5)
    end

    def categories
      @categories = Category.all
    end

    def pages
      @pages = Page.all
    end

    def archive
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
