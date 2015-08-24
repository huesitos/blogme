class Dashboard::AuthorsController < Dashboard::DashboardController
  before_action :authenticate_author
  before_action :authorize_author, only: [:index, :new, :create, :destroy]

  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
    @social_links = @author.social_links
  end

  def create
    author_params[:nickname].downcase! if author_params[:nickname]
    @author = Author.new(author_params)
    @author.password = password_params[:password]
    @author.password_confirmation = password_params[:password_confirmation]

    respond_to do |format|
      if @author.save
        flash[:success] = "A new author was added."
        format.html { redirect_to dashboard_author_path(@author.id) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @author = Author.find(params[:id])

    respond_to do |format|
      if @author.update(author_params)
        flash[:success] = "Author #{@author.nickname} was updated."
        format.html { redirect_to dashboard_author_path(@author.id) }
      else
        format.html { render :edit }
      end
    end
  end

  def update_social_links
    @author = Author.find(params[:author_id])

    respond_to do |format|
      if @author.update(social_links: social_links_params)
        flash[:success] = "Author #{@author.nickname} was updated."
        format.html { redirect_to dashboard_author_path(@author.id) }
      else
        format.html { render :edit }
      end
    end
  end

  def update_password
    @author = Author.find(params[:author_id])
    @author.password = password_params[:password]
    @author.password_confirmation = password_params[:password_confirmation]

    respond_to do |format|
      if @author.save
        flash[:success] = "Author #{@author.nickname} was updated."
        format.html { redirect_to dashboard_author_path(@author.id) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    respond_to do |format|
      flash[:success] = "The author was deleted."
      format.html { redirect_to dashboard_authors_path }
    end
  end

  private

    def author_params
      params.require(:author).permit(
        :name,
        :last_name,
        :nickname,
        :image,
        :message,
        :email)
    end

    def password_params
      params.require(:password).permit(
        :password,
        :password_confirmation)
    end

    def social_links_params
      params.require(:social_links).permit(
        :google,
        :youtube,
        :instagram,
        :pinterest,
        :etsy)
    end
end
