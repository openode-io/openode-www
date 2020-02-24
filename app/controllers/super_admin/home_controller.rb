class SuperAdmin::HomeController < SuperAdminController
  def index
    #TODO: Add a dashboard with some basic stats. Redirecting for now.
    redirect_to '/super_admin/websites'
  end
end
