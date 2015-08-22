class TagsController < BlogControllerController

  def show
    @tag = Tag.find_by(name: params[:tag])
    @posts = @tag.posts

    render "posts/index"
  end
end
