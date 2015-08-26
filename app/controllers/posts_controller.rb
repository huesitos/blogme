class PostsController < BlogController

  def index
    if params[:tag]
      @posts = Tag.find_by(name: params[:tag]).posts
    else
      @posts = Post.all.order(created_at: :desc)
    end
    @posts.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post.increment!(:view_count)
    @comment = Comment.new(name: '')
    @comments = @post.comments.order(created_at: :desc)

    # Get three random posts from a category
    # !!! Fix: the if is a hack so posts tests pass without
    # the post having a category. This seems to be a good
    # place where stubs and mocks help...
    if @post.category
      @category_posts = @post.category.random_posts([@post.id])
    end

    @author = @post.author
  end
end
