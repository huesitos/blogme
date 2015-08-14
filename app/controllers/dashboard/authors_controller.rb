class Dashboard::AuthorsController < ApplicationController

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
      format.html { redirect_to dashboard_authors_path }
    end
  end

  private

    def author_params
      params.require(:author).permit(:name, :last_name, :password, :image, :message, :email)
    end
end
