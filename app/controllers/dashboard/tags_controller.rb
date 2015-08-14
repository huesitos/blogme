class Dashboard::TagsController < Dashboard::DashboardController
  before_action :authenticate_author!

	def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts
  end
end
