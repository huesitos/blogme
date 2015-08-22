class PagesController < BlogControllerController

  def show
    @page = Page.find_by(name: params[:name])
  end
end
