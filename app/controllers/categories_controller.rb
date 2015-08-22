class CategoriesController < BlogController

  def show
    @category = Category.find_by(name: params[:category])
    @posts = @category.posts

    render 'posts/index'
  end
end
