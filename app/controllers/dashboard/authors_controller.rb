class Dashboard::AuthorsController < Dashboard::DashboardController
  before_action :authenticate_author!
  before_action :authorize_author!

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        flash[:notice] = "A new author was added."
        format.html { redirect_to dashboard_authors_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @author = Author.find(params[:id])

    respond_to do |format|
      if @author.update(author_params)
        flash[:notice] = "Author #{@author.email} was updated."
        format.html { redirect_to dashboard_authors_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    respond_to do |format|
      flash[:notice] = "The author was deleted."
      format.html { redirect_to dashboard_authors_path }
    end
  end

  private

    def author_params
      params.require(:author).permit(
        :name,
        :last_name,
        :nickname,
        :password,
        :image,
        :message,
        :email)
    end

    def authorize_author!
      if current_author.role != "admin"
        redirect_to dashboard_posts_path
      end
    end
end
