class Dashboard::PostsController < ApplicationController
  def index
    @posts = Post.all
    @tags_with_frequency = Tag.all.map do |tag| 
      [tag, tag.posts.length]
    end
  end

  def new
    @post = Post.new
  end

  def create
    tags = []
    @post = Post.new(post_params)

    # Split by ',' and then by ' ' to remove whitespace
    if params[:tags]
      tmp_tags = params[:tags].split(',').join('').split(' ')

      tmp_tags.each do |tag|
        tags << Tag.find_or_create_by(name: tag)
      end
      @post.tags << tags
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to :dashboard_posts }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.map(&:name).join(', ')
  end

  private
  
    def post_params 
      params.require(:post).permit(:title, :description)
    end 
end