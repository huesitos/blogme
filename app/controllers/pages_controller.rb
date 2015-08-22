class PagesController < BlogController

  def show
    @page = Page.find_by(name: params[:name])
  end
end
