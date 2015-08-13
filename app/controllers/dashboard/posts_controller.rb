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
    @post = Post.new(post_params)
    @post.tags << get_tags

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

  def update
    @post = Post.find(params[:id])

    # Change posts tags
    # If any of the post's previous tags posts.length drops to zero
    # it means no other post references the tag, and thus it should be
    # destroyed.
    new_tags = get_tags
    old_tags = @post.tags.to_a
    @post.tags = new_tags

    old_tags.each { |tag| if tag.posts.length == 0 then tag.destroy end }

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to :dashboard_posts }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :description)
    end

    def get_tags
      tags = []
      # Split by ',' and then by ' ' to remove whitespace
      if params[:tags]
        tmp_tags = params[:tags].split(',').join('').split(' ')

          tmp_tags.each do |tag|
          tags << Tag.find_or_create_by(name: tag)
        end
      end

      tags
    end
end
