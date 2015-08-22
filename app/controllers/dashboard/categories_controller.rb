class Dashboard::CategoriesController < Dashboard::DashboardController
  before_action :authenticate_author!

  def index
    @categories = Category.all
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "A new category was created."
    end
    redirect_to dashboard_categories_path
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to dashboard_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to dashboard_categories_path
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
end
