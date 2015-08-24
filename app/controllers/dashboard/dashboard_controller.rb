class Dashboard::DashboardController < ApplicationController
  layout :dashboard_layout

  private

    def dashboard_layout
      "dashboard"
    end

    def authenticate_author
      if not current_author
        redirect_to(dashboard_log_in_path)
      end
    end

    def authorize_author
      if not admin_author?
        redirect_to dashboard_posts_path
      end
    end
end
