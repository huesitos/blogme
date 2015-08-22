class Dashboard::PagesController < Dashboard::DashboardController
  before_action :authenticate_author
  before_action :authorize_author

  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(page_params)

    if @page.save()
      flash[:success] = "A new page was created."

      redirect_to dashboard_pages_path
    else
      render :new
    end
  end

  def update
    @page = Page.find(params[:id])

    if @page.update(page_params)
      flash[:success] = "The page #{@page.name} was updated."
      redirect_to dashboard_pages_path
    else
      render :edit
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    redirect_to dashboard_pages_path
  end

  private

    def page_params
      params.require(:page).permit(:name, :content)
    end
end
