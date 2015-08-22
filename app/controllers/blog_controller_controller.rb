class BlogControllerController < ApplicationController
  before_action :popular_posts
  before_action :archive
  before_action :categories

  private

    def popular_posts
      @popular_posts = Post.all.order(view_count: :desc).limit(5)
    end

    def categories
      @categories = Category.all
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
